# Infrastructure on Kubernetes

## Setup

First, create a machine account access token for Bitwarden Secrets Manager. Then run the following to set up a secret for the token:

```sh
kubectl create ns external-secrets
kubectl create secret generic bitwarden-access-token -n external-secrets --from-literal=token=<machine-account-token>
```
