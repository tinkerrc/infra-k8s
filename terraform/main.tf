module "talos_image" {
  source = "./modules/hcloud-talos"
}

module "controlplane" {
  source       = "./modules/hcloud-node"
  name         = "controlplane"
  ssh_keys     = var.ssh_keys
  image        = module.talos_image.id
  hcloud_token = var.hcloud_token
  labels = {
    "type" = "controlplane"
  }
}

resource "hcloud_firewall" "controlplane" {
  name = "controlplane-fw"
}
# NOTE: I don't like exposing
# resource "hcloud_load_balancer" "controlplane" {
#   name               = "controlplane-lb"
#   load_balancer_type = "lb11"
#   network_zone       = "eu-central"
#   labels = {
#     "type" = "controlplane"
#   }
# }

# resource "hcloud_load_balancer_service" "controlplane" {
#   listen_port      = 6443
#   destination_port = 6443
#   protocol         = "tcp"
#   load_balancer_id = hcloud_load_balancer.controlplane.id
# }

# resource "hcloud_load_balancer_target" "controlplane" {
#   load_balancer_id = hcloud_load_balancer.controlplane.id
#   type             = "label_selector"
#   label_selector   = "type=controlplane"
# }
