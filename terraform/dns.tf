resource "cloudflare_zone" "domain" {
  name = local.domain
  account = {
    id = var.cloudflare_account_id
  }
  type = "full"
}

resource "cloudflare_dns_record" "example_dns_record" {
  zone_id = cloudflare_zone.domain.id
  name    = local.cluster_api_host
  ttl     = 3600
  type    = "A"
  content = module.talos.public_ipv4_list[0]
}

import {
  id = "702179c473abaf1a496ba225d8b23262"
  to = cloudflare_zone.domain
}
