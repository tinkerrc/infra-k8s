provider "hcloud" {
  token = var.hcloud_token
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

provider "flux" {
  kubernetes = {
    host                   = module.talos.kubeconfig_data.host
    client_certificate     = module.talos.kubeconfig_data.client_certificate
    client_key             = module.talos.kubeconfig_data.client_key
    cluster_ca_certificate = module.talos.kubeconfig_data.cluster_ca_certificate
  }

  git = {
    url = "https://github.com/${var.github_org}/${var.github_repository}.git"
    http = {
      username = "git" # This can be any string when using a personal access token
      password = var.github_token
    }
  }
}
