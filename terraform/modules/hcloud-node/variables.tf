variable "hcloud_token" {
  type      = string
  sensitive = true
}

variable "name" {
  type        = string
  description = "Name of the node"
}

variable "datacenter" {
  type    = string
  default = "hil-dc1"
}

variable "server_type" {
  type    = string
  default = "cx22"
}

variable "image" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}

variable "labels" {
  type    = map(string)
  default = {}
}
