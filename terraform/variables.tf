variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "ssh_keys" {
  type = list(string)
}
