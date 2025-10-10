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

Once you have ArgoCD up and running, you can use it to manage your applications and resources in the Kubernetes cluster.

In this repository you will find the following folders:

* `apps/`: Contains applications that are deployed to the cluster.
* `addons/`: Contains additional components that enhance the cluster functionality.
* `charts/`: Contains Helm charts for deploying applications and addons.
* `templates/`: Contains Cookiecutter templates for generating Kubernetes manifests.

## Disaster recovery

- 2025-09-14 - First version of disaster recovery steps
- 2025-10-09 - MetalLB stop working in production for Adguard Home 53 port

### Setup core cluster

#### Recreate core cluster (lima + microk8s)

1. Delete the existing lima instance and recreate it with the core.yaml file:

```bash
limactl delete microk8s-core
limactl start --name=microk8s-core ./core.yaml
```

2. Then follow the steps in [apps/lima/README.md](apps/lima/README.md) to setup microk8s and enable the addons.
3. Update the kubeconfig file following the steps in [apps/lima/README.md](apps/lima/README.md).
4. [setup Hashicorp Vault](apps/vault/README.md)
5. [setup External Secrets](addons/external-secrets/README.md)
6. [setup ArgoCD](apps/argocd/README.md)
7. Install core addon [cert-manager](addons/cert-manager/README.md)
8. Enable ssl support in vault and argo by upgrade helm with the values-ssl.yaml file:

#### Configure dev cluster to test restoration of the shared folder in the machine

1. Install all the needed addons [apps/lima/README.md](apps/lima/README.md)
2. Register the new cluster credentials in vault to add it into ArgoCD
3. Starting with [coredns](addons/coredns/README.md) config to add additional configuration
2. After that you need the [external-secrets](addons/external-secrets/README.md) remember that
   for establish connection with vault you need to add the [home-internal-root-ca](addons/external-secrets/README.md) as secret in the external-secrets namespacee
3. Then install the [cert-manager](addons/cert-manager/README.md)
4. Finally test that everything works by installing home assistant
  1. Install the home assistant config
  2. Then the home assistant
  3. Finally the home assistant addons and restart
