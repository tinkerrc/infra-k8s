terraform {
  backend "s3" {
    bucket       = "tinkerrc-us-east-2-tf-state"
    key          = "lab/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.52"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.9.0-alpha.0"
    }
  }
}
