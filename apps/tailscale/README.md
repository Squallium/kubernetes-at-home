curl -fsSL https://tailscale.com/install.sh | sh
sudo dpkg --configure -a
sudo apt -f install
sudo tailscale up


sudo nano /var/snap/microk8s/current/args/kubelet
--node-ip=192.168.1.128

echo '--node-ip=192.168.1.130' | sudo tee -a /var/snap/microk8s/current/args/kubelet
sudo tail -5 /var/snap/microk8s/current/args/kubelet

kubectl run net-test --rm -it --restart=Never --image=curlimages/curl -- curl -vk --connect-timeout 5 https://<IP_ADDRESS>