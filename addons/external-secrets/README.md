## Installing External Secrets Addon

This addon will allow us mount secrets from various secret management systems into Kubernetes as native Kubernetes
secrets. In our case from the HashiCorp Vault.

First we need to add the Helm repository for External Secrets:

```bash
helm repo add external-secrets https://charts.external-secrets.io
helm repo update
```

Then we can install the External Secrets Helm chart into the `external-secrets` namespace:

```bash
helm install external-secrets external-secrets/external-secrets --namespace external-secrets --create-namespace
```

Now we can create a new policy in the Vault dashboard with the name sso-read with the following content:

```hcl
path "secret/data/*" {
  capabilities = ["read"]
}
```

Then we have to access to the pod/vault-0 and create a token using the vault CLI, I don't have the option to do this in
the Vault dashboard. So I will install the CLI:

```bash
scoop install vault
```

Then we need to export the Vault address and token as environment variables:

```bash
export VAULT_ADDR=http://vault.vault.svc
export VAULT_TOKEN=s.xxxxxx
```

For windows in your PowerShell profile:

```powershell
$env:VAULT_ADDR = "http://vault.famrefveg.local"
$env:VAULT_TOKEN = "s.xxxxxx"
```

Then we can create the token:

```bash
vault token create -policy=eso-read -period=24h -renewable=true
```

Now we need to use the toke to create a Kubernetes secret that the External Secrets controller can use to access the Vault by configuring a SecretStore:

```bash
kubectl create secret generic vault-token --from-literal=token=s.xxxxxx... -n default
```