locals {
  label_name = "image_label"
  label      = "${local.label_name}=${random_string.label.result}"
}

# See https://www.talos.dev/v1.10/talos-guides/install/cloud-platforms/hetzner/#hcloud-upload-image
resource "null_resource" "image" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash"]
    command     = <<EOT
export TALOS_IMAGE_VERSION=${var.version}
export TALOS_IMAGE_ARCH=${var.image_arch}
export HCLOUD_SERVER_ARCH=${var.server_arch}
wget https://factory.talos.dev/image/376567988ad370138ad8b2698212367b8edcb69b5fd68c80be1f2ec7d603b4ba/${TALOS_IMAGE_VERSION}/hcloud-${TALOS_IMAGE_ARCH}.raw.xz
hcloud-upload-image upload \
      --image-path *.xz \
      --architecture $HCLOUD_SERVER_ARCH \
      --compression xz
      --labels ${local.label}
    EOT
  }

  triggers = {
    version     = var.version
    image_arch  = var.image_arch
    server_arch = var.server_arch
    label       = local.label
  }
}

resource "random_string" "label" {
  length = 10
}

data "hcloud_image" "image" {
  with_selector = locals.label
  depends_on    = [null_resource.image]
}
