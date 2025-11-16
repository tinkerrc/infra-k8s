resource "hcloud_server" "node" {
  name        = "node-${var.name}"
  image       = var.image
  server_type = var.server_type
  datacenter  = var.datacenter
  ssh_keys    = var.ssh_keys

  delete_protection  = true
  rebuild_protection = true

  public_net {
    ipv4 = hcloud_primary_ip.primary_ipv4
    ipv6 = hcloud_primary_ip.primary_ipv6
  }

  lifecycle {
    ignore_changes  = [ssh_keys]
    prevent_destroy = true
  }

  labels = var.labels
}

resource "hcloud_primary_ip" "primary_ipv4" {
  name          = "primary-ipv4-${var.name}"
  datacenter    = var.datacenter
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_primary_ip" "primary_ipv6" {
  name          = "primary-ipv6-${var.name}"
  datacenter    = var.datacenter
  type          = "ipv6"
  assignee_type = "server"
  auto_delete   = false
}
