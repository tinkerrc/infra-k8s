locals {
  domain           = var.domain
  cluster_api_host = "kube.${local.domain}"
  cluster_domain   = "cluster.${local.domain}.local"
  current_ipv4     = "${chomp(data.http.current_ipv4.response_body)}/32"
}

data "http" "current_ipv4" {
  url = "https://ipv4.icanhazip.com"
}

module "talos" {
  source = "hcloud-talos/talos/hcloud"

  # https://registry.terraform.io/modules/hcloud-talos/talos/hcloud
  version = "2.20.2"
  # Use versions compatible with each other and supported by the module/Talos
  # Remember to update _packer/hcloud.auto.pkrvars.hcl and re-run _packer/create.sh to upload image
  talos_version      = "v1.11.3"
  kubernetes_version = "1.34.1"
  cilium_version     = "1.18.4"

  cilium_enable_encryption        = true
  cilium_enable_service_monitors  = true
  deploy_prometheus_operator_crds = true

  datacenter_name = "fsn1-dc14"
  hcloud_token    = var.hcloud_token

  cluster_name     = local.domain
  cluster_domain   = local.cluster_domain
  cluster_api_host = local.cluster_api_host

  firewall_use_current_ip   = false
  firewall_kube_api_source  = [local.current_ipv4]
  firewall_talos_api_source = [local.current_ipv4]

  control_plane_count          = 3
  control_plane_server_type    = "cx33"
  control_plane_allow_schedule = true
  worker_nodes                 = []

  enable_floating_ip = true
  enable_ipv6        = false
  network_ipv4_cidr  = "10.0.0.0/16"
  node_ipv4_cidr     = "10.0.1.0/24"
  pod_ipv4_cidr      = "10.0.16.0/20"
  service_ipv4_cidr  = "10.0.8.0/21"

  kubelet_extra_args = {
    # https://docs.siderolabs.com/kubernetes-guides/monitoring-and-observability/deploy-metrics-server
    "rotate-server-certificates" : true
  }

  extraManifests = [
    # Metrics Server API
    # You may need to use kubectl -f <url> on existing clusters
    "https://raw.githubusercontent.com/alex1989hu/kubelet-serving-cert-approver/main/deploy/standalone-install.yaml",
    "kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/high-availability-1.21+.yaml"
  ]

  tailscale = {
    # This seems to only work at bootstrap-time
    enabled  = var.enable_tailscale_extension
    auth_key = var.tailscale_auth_key
  }
}

resource "flux_bootstrap_git" "this" {
  embedded_manifests = true
  path               = "clusters/${local.domain}"
  cluster_domain     = local.cluster_domain
  components_extra = [
    "image-reflector-controller", "image-automation-controller", "source-watcher"
  ]
}
