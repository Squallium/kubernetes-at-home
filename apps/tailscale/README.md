curl -fsSL https://tailscale.com/install.sh | sh
sudo dpkg --configure -a
sudo apt -f install
sudo tailscale up