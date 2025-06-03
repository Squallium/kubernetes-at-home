## Steps to follow for freeing up port 53 in limactl

1. Check if the systmd-resolved service is running:
   ```bash
   systemctl status systemd-resolved
   ```
2. If it is running, disable the service:
   ```bash
   sudo systemctl disable --now systemd-resolved
   ```

3. Point the `/etc/resolv.conf` to another valid DNS server:
   ```bash
   sudo rm /etc/resolv.conf
   echo "nameserver 1.1.1.1" | sudo tee /etc/resolv.conf
   ```
4. Verify that you still have nameserver resolution:
   ```bash
   ping google.com -c 2
   nslookup google.com
   ```

### Troubleshooting

If you see this error "sudo: unable to resolve host lima-microk8s-dev: Name or service not known" add the following
line "127.0.1.1 lima-microk8s-dev" to the /etc/hosts file: