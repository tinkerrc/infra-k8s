output "id" {
  value       = hcloud_server.node.id
  description = "server ID"
}

output "ipv4_address" {
  value = hcloud_primary_ip.primary_ipv4.ip_address
}

output "ipv6_address" {
  value = hcloud_primary_ip.primary_ipv6.ip_address
}
