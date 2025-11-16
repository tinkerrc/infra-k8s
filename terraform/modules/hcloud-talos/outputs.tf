output "selector" {
  value       = local.label
  description = "data hcloud_image.with_selector value"
}

output "id" {
  value = data.hcloud_image.image.id
}
