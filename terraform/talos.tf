locals {
  cluster_name = "tinkerrc-lab"
}
resource "talos_machine_secrets" "this" {}

data "talos_machine_configuration" "this" {
  cluster_name     = local.cluster_name
  machine_type     = "controlplane"
  cluster_endpoint = "https://${hcloud_load_balancer.controlplane.ipv4}:6443"
  machine_secrets  = talos_machine_secrets.this.machine_secrets
}

data "talos_client_configuration" "client" {
  cluster_name = local.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes = 
}

resource "talos_machine_configuration_apply" "controlplane" {

}

resource "talos_machine_bootstrap" "this" {
  depends_on = [
    talos_machine_configuration_apply.this
  ]
  node                 = 
  client_configuration = talos_machine_secrets.this.client_configuration
}