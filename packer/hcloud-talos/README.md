# Hetzner Cloud Talos Linux Image

Follow [Talos Linux instructions](https://www.talos.dev/v1.10/talos-guides/install/cloud-platforms/hetzner/#packer) to create a snapshot for creating Talos-based Kubernetes cluster.

```sh
# First you need set API Token
export HCLOUD_TOKEN=${TOKEN}

# Upload image
packer init .
packer build .
# Save the image ID
export IMAGE_ID=<image-id-in-packer-output>
```
