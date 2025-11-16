terraform {

  backend "s3" {
    bucket = "tinkerrc-us-east-2-tf-state"
    key    = "terraform.tfstate"
    region = "us-east-2"
    # use_lockfile = true
    encrypt = true
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }

    hcloud = {
      source  = "hetznercloud/hcloud"
      version = ">= 1.54.0"
    }

    http = {
      source  = "hashicorp/http"
      version = ">= 3.5.0"
    }

    flux = {
      source  = "fluxcd/flux"
      version = "1.7.4"
    }
  }

}
