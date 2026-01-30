Access to the microk8s shell:

```bash
limactl shell microk8s
```

Provide sudo access to your computer user and restart the microk8s instance:

```bash
sudo usermod -a -G microk8s kuber
limactl restart microk8s
```

Enable the following microk8s addons:

```bash 
sudo microk8s enable dns 
sudo microk8s enable hostpath-storage 
sudo microk8s enable ingress 
sudo microk8s enable metallb (not core)
sudo microk8s enable metrics-server 
sudo microk8s enable community (optional)
```

Check the status of microk8s:

```bash
microk8s status
```

Get the Kubernetes dashboard token:

```bash
microk8s kubectl -n kube-system describe secret $(microk8s kubectl -n kube-system get secret | grep default-token | awk '{print $1}')
```

And enable the dashboard proxy:

```bash
microk8s dashboard-proxy
```

You should see something like this:

```
Checking if Dashboard is running.
Infer repository core for addon dashboard
Waiting for Dashboard to come up.
Trying to get token from microk8s-dashboard-token
Waiting for secret token (attempt 0)
Dashboard will be available at https://127.0.0.1:10443
Use the following token to login:
```

Use the external IP address to access the dashboard in your browser with that port and paste the token to login.

## Configure kubectl in a different computer for accessing the microk8s cluster

Install kubectl, kubectx and kubens, then save the microk8s configuration to your local kubeconfig file:

```bash
microk8s config > ~/.kube/config
```

If you have multiple microk8s instances, you need to combine the kubeconfig files with the following command. Remember
to replace the identifiers before combine them.

```bash
$env:KUBECONFIG = "$HOME\.kube\core-config;$HOME\.kube\dev-config;$HOME\.kube\pro-config"
kubectl config view --flatten > $HOME\.kube\config
```

## Check ingress controller with nginx

Create a nginx deployment and expose it:

```bash
kubectl create deployment demo --image=nginx --port=80
kubectl expose deployment demo --port=80 --target-port=80 --type=ClusterIP
```

Then apply the ingress configuration in the `apps/nginx` directory:

```bash
kubectl apply -f apps/nginx/ingress.yaml
```

Now you can access the nginx deployment via the ingress controller. You can modify you local `/etc/hosts` file to point
the domain `demo.local` to the IP address of your microk8s instance. For example:

```bash
192.168.1.1 demo.local
```

And access it in your browser http://demo.local If you can see the nginx welcome page, everything is working fine. Now
you can delete the deployment and ingress:

```bash
kubectl delete ingress demo-ingress
kubectl delete service demo
kubectl delete deployment demo
```