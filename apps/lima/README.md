# Setup Lima and MicroK8s on macOS

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

Run three microk8s instance with lima:

```bash
limactl start --name=microk8s-core ./microk8s-bridged.yaml
limactl start --name=microk8s-dev ./microk8s-bridged.yaml
limactl start --name=microk8s-pro ./microk8s-bridged.yaml
```

If something fails related to the network, you can try to fix it by editing the network configuration file:

```bash
nano .lima/_config/networks.yaml
limactl sudoers > etc_sudoers.d_lima && sudo install -o root etc_sudoers.d_lima "/private/etc/sudoers.d/lima"
```

Check the network configuration and make sure the `bridged` network is set up correctly. You can also check the lima
logs for any errors:

```bash
limactl shell microk8s ip -br a
```

