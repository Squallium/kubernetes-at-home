### Hashicorp Vault authentication

You need to create a new secret with the secret-id of the role you want to use

```bash
kubectl create secret generic vault-approle-secret --from-literal=secret-id=xxxxxx -n argocd
```