# kubernetes-at-home

Setting up a Kubernetes cluster at home can be a fun and educational project. This repository contains various
resources, scripts, and configurations to help you set up and manage a Kubernetes cluster on your home network.

## Setup cluster and ArgoCD

I'm going to use ArgoCD to manage the cluster and deploy applications. The following steps will guide you through the
setup process, because at least we need:

* a Kubernetes cluster
* a way to store secrets
* a way to access those secrets
* setup ArgoCD
* setup a GitOps folder structure

## Steps

1. [setup lima and microk8s in macOS](apps/lima/README.md)
2. [setup Hashicorp Vault](apps/vault/README.md)
3. [setup External Secrets](addons/external-secrets/README.md)
4. [setup ArgoCD](apps/argocd/README.md)

