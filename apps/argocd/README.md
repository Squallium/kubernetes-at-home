## Installing ArgoCD

To install ArgoCD, you can use Helm, which is a package manager for Kubernetes. Below are the steps to install ArgoCD
using Helm.

```shell
kubectl create namespace argocd
kubens argocd
```

We need to manually create the vault-approle-secret secret in the argocd namespace with the secret-id of the role you want to use:

```bash
kubectl create secret generic vault-approle-secret --from-literal=secret-id=xxxxxx -n argocd
```

Add the ArgoCD Helm repository and update it:

```shell
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

Install ArgoCD using our custom values file located at `apps/argocd/values.yaml`.

```shell
helm install argocd argo/argo-cd --namespace argocd --values apps/argocd/values.yaml --version 9.0.5
```

These are the notes you will see after the installation:

```
NOTES:
In order to access the server UI you have the following options:

1. kubectl port-forward service/argocd-server -n argocd 8080:443

    and then open the browser on http://localhost:8080 and accept the certificate

2. enable ingress in the values file `server.ingress.enabled` and either
      - Add the annotation for ssl passthrough: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-1-ssl-passthrough
      - Set the `configs.params."server.insecure"` in the values file and terminate SSL at your ingress: https://argo-cd.readthedocs.io/en/stable/operator-manual/ingress/#option-2-multiple-ingress-objects-and-hosts


After reaching the UI the first time you can login with username: admin and the random password generated during the installation. You can find the password by running:

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

(You should delete the initial secret afterwards as suggested by the Getting Started Guide: https://argo-cd.readthedocs.io/en/stable/getting_started/#4-login-using-the-cli)
```

Now if you have your /etc/hosts file configured to point the domain `argocd.home` to the IP address of your
microk8s instance, you can access the ArgoCD UI at https://argocd.home

We can get the initial admin password with the following command:

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

Now that we have the Argo CRDs, we are ready to install the following custom charts:
 - argocd-addons with the cmp-plugin configmap for avp and helm-secrets plugin configuration
 - argocd-config which will set up the default root project based on environment names pointed to this repository in the gitops/envs/<environment> folder.

First we need to install the repo:

```shell
helm repo add squallium https://squallium.github.io/kubernetes-at-home
helm repo update
```

Then install argocd-addons and restart argocd-repo-server before installing argocd-config:

```shell
helm install argocd-addons squallium/argocd-addons --namespace argocd --version 0.0.2
helm install argocd-config squallium/argocd-config --namespace argocd --version 0.0.9
```

If secrets are ok you should see the clusters availables in the ArgoCD UI.

```shell
kubectl rollout restart deployment argocd-repo-server -n argocd
kubectl rollout restart statefulset argocd-application-controller -n argocd
kubectl rollout restart deployment argocd-server -n argocd
```

### Troubleshooting:

Export the config data to a file:

```shell
kubectl get secret argocd-cluster-dev-secret -n argocd -o json | jq -r '.data.config' | base64 --decode > output.json
```

And decode the content of the file:

```shell
cat .\output.json | base64 -d
```

Finally check the logs of the argocd-application-controller to see if there are any errors:

```shell
stern argocd-application-controller -n argocd
```

### Upgrading ArgoCD

To upgrade ArgoCD, you can use the following command:

```shell
helm upgrade argocd argo/argo-cd --namespace argocd --values apps/argocd/values.yaml --values apps/argocd/values-ssl.yaml --version <version>
```

And for upgrade the config chart

```shell
helm upgrade argocd-config .\charts\argocd-config\ --namespace argocd --values .\charts\argocd-config\values.yaml --version <version>    
```