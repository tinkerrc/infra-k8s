variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "tailscale_auth_key" {
  type        = string
  sensitive   = true
  description = "Tailscale auth key used to setup new devices"
}

variable "cloudflare_api_token" {
  type        = string
  sensitive   = true
  description = "Cloudflare API token with ability to write DNS records"
}

variable "cloudflare_account_id" {
  type = string
}

variable "github_org" {
  type    = string
  default = "tinkerrc"
}

variable "github_repository" {
  type    = string
  default = "infra-k8s"
}

variable "github_token" {
  type      = string
  sensitive = true
}
