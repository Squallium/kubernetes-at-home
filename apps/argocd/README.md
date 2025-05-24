## Installing ArgoCD

To install ArgoCD, you can use Helm, which is a package manager for Kubernetes. Below are the steps to install ArgoCD
using Helm.

```shell
kubectl create namespace argocd
kubens argocd
```

Installing the helm chart in the cluster

```shell
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
```

Install ArgoCD using our custom values file located at `apps/argocd/values.yaml`.

```shell
helm install argocd argo/argo-cd --namespace argocd --values apps/argocd/values.yaml 
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

Now if you have your /etc/hosts file configured to point the domain `argocd.local.lan` to the IP address of your
microk8s instance, you can access the ArgoCD UI at https://argocd.local.lan

We can get the initial admin password with the following command:

```shell
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```