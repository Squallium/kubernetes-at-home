## Installing Hashicorp Vault

In order to manage secrets in our Kubernetes cluster, we will install Hashicorp Vault. This will allow us to securely
store and access sensitive information such as API keys, passwords, and other secrets.

First you need to go to the microk8s shell and enable the hostpath-storage addon:

```bash
sudo microk8s enable hostpath-storage
```

Add the Hashicorp Vault Helm repository and update it:

```bash
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
```

Then, you can install Vault using Helm. Make sure you have Helm installed and configured in your microk8s environment.

```bash
helm install vault hashicorp/vault -n vault --create-namespace --values apps/vault/values.yaml
``` 

Now you should see the pod/vault-0 in ready 0/1 and in you run this command:

```bash
kubectl exec -it vault-0 -n vault -- vault status
```

You should see the Vault status, which indicates that it is initialized but sealed. This is expected, as we need to
initialize and unseal Vault before we can use it. For that you have to run the init this first time and make sure you
save the unseal keys and the initial root token.

```bash
kubectl exec -it vault-0 -n vault -- vault operator init
```

Now you can unseal the Vault by using the following command three times or by going directy into your browser and
accessing the Vault UI http://vault.internal:

```bash
kubectl exec -it vault-0 -n vault -- /bin/sh
vault operator unseal
```

Then you can finally log in using the root token you saved before:

Now let's create an engine and a test secret for testing ArgoCD and the external secrets which will be the only addon
not
manage by ArgoCD because in ArgoCD configurations like clusters or repo are manage by kubernetes secrets.

Go to "Secrets Engines" and enable the "KV" engine. 
1. In path you can put "secret" in maximun number of versions at lesat
2. Then create a new secret "myapp/api-key" and add "api_key" as "abcd1234" and "username" as "admin"


## Upgrade helm chart and values

First remember to update the Helm repository to ensure you have the latest version of the chart:

```bash
helm repo update
```

For upgrading the helm chart and values, you can use the following command:

```bash
helm upgrade vault hashicorp/vault -n vault --values apps/vault/values.yaml --version <version>
```