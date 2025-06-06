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

We need to use the token to create a Kubernetes secret that the External Secrets controller can use to access the Vault by configuring a SecretStore:

```bash
kubectl create secret generic vault-token --from-literal=token=hvs.xxxxxx... -n default
```

Now we have to create a "ClusterSecretStore" resource in Kubernetes that defines how to access the Vault. Apply the vault.secretstore.yaml file:

```bash
kubectl apply -f addons/external-secrets/vault.clustersecretstore.yaml
```

And finally, for testing purposes, we can create a test `ExternalSecret` resource that will be populated with the secret from Vault by applying the `vault.secret.yaml` file:

```bash
kubectl apply -f addons/external-secrets/test.externalsecret.yaml
```

You can check the decoded content of the secret created in Kubernetes by running:

```bash
kubectl get secret myapp-secret -o jsonpath="{.data.api_key}" | base64 --decode 
kubectl get secret myapp-secret -o jsonpath="{.data.username}" | base64 --decode
```

### Troubleshooting:

You can check the secret values with the following command:

```bash
vault kv get secret/myapp/api-key
```

You can check the token details and its policies with:

```bash
vault token lookup s.xxxxxx
``` 

## Use AppRole instead of Token

Enable the AppRole authentication method in Vault with the following command:

```bash
vault auth enable approle
```

First we need to create a new AppRole in Vault with the following command:

```bash
vault write auth/approle/role/eso-role token_policies="eso-read" token_ttl=1h token_max_ttl=4h secret_id_ttl=24h token_period=1h token_renewable=true
```

Get the role ID and secret ID for the AppRole:

```bash
vault read auth/approle/role/eso-role/role-id
```

Increase the secret ID TTL to 720 hours:

```bash
vault write auth/approle/role/eso-role secret_id_ttl=720h
```

Get the secret ID for the AppRole:

```bash
vault write -f auth/approle/role/eso-role/secret-id
```

Create the vault-approle-secret Opaque in Kubernetes with the secret ID.

```bash
kubectl create secret generic vault-approle-secret --from-literal=secret-id=xxxxxx -n default
```

Or you can update the vault-approle-secret with the new secret ID after encoding it in base64:

```bash
echo -n "xxxxxx" | base64
```

Then patch the secret in Kubernetes:

```bash
kubectl patch secret vault-approle-secret -p '{"data":{"secret-id":"xxxxxx"}}' -n default
```
