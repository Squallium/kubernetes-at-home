curl -fsSL https://tailscale.com/install.sh | sh
sudo dpkg --configure -a
sudo apt -f install
sudo tailscale up


sudo nano /var/snap/microk8s/current/args/kubelet
--node-ip=192.168.1.128