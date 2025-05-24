# kubernetes-at-home

## setup lima and microk8s in macOS

Installing brew and oh-my-zsh:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

Install lima and socket_vmnet, which is required for bridged networking in lima:

```bash
brew install lima
brew install socket_vmnet
````

Copy the socket_vmnet binary to a location that lima can access:

```bash
sudo mkdir -p /opt/socket_vmnet/bin
realpath /usr/local/opt/socket_vmnet
sudo cp /usr/local/Cellar/socket_vmnet/1.2.1/bin/socket_vmnet /opt/socket_vmnet/bin
```

Create a lima configuration file for microk8s with bridged networking:

```bash
nano microk8s-bridged.yaml
```

```yaml
images:
  - location: "https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"
    arch: "x86_64"

cpus: 4
memory: "6GiB"
disk: "40GiB"

mounts:
  - location: "~"
    writable: true

networks:
  - lima: bridged

containerd:
  system: false
  user: false

provision:
  - mode: system
    script: |
      #!/bin/bash
      set -eux
      apt update
      apt install -y snapd
      snap install microk8s --classic
      usermod -a -G microk8s lima
      echo 'export PATH=$PATH:/snap/bin' >> /etc/profile
```

Run your microk8s instance with lima:

```bash
limactl start --name=microk8s ./microk8s-bridged.yaml
```

If something fails related to the network, you can try to fix it by editing the network configuration file:

```bash
nano .lima/_config/networks.yaml
limactl sudoers > etc_sudoers.d_lima && sudo install -o root etc_sudoers.d_lima "/private/etc/sudoers.d/lima"
```

Check the network configuration and make sure the `bridged` network is set up correctly. You can also check the lima logs for any errors:

```bash
limactl shell microk8s ip -br a
```

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
sudo microk8s enable ingress 
sudo microk8s enable dashboard 
sudo microk8s enable community
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

Install kubectl and kubens, then save the microk8s configuration to your local kubeconfig file:

```bash
microk8s config > ~/.kube/config
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

Now you can access the nginx deployment via the ingress controller. You can modify you local `/etc/hosts` file to point the domain `demo.local` to the IP address of your microk8s instance. For example:

```bash
192.168.1.1 demo.local.lan
```

And access it in your browser http://demo.local.lan If you can see the nginx welcome page, everything is working fine. Now you can delete the deployment and ingress:

```bash
kubectl delete ingress demo-ingress
kubectl delete service demo
kubectl delete deployment demo
```
