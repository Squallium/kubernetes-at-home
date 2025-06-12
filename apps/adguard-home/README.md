## Another strategy with floating IPs and Metallb

1. Install MetalLB in your MicroK8s cluster:
   ```bash
   microk8s enable metallb
   ```

2. Check that metalLB is running:
   ```bash
   microk8s kubectl get pods -n metallb-system
   ```

3. For checking that MetalLB is working apply the test file metallb-test.yaml:
   ```bash
   kubectl apply -f .\apps\adguard-home\tests\metallb-test.yaml
   ```
   
4. Check the new service to find out the IP assigned by MetalLB:
   ```bash
   microk8s kubectl get svc -n nginx-test
   ```
   
5. Finally open a browser and navigate the http://<IP_ADDRESS> to see the nginx welcome page.

## Installing AdGuard Home

1. Install the AdGuard Home Helm chart, first without setting the ingress port. This will point by default to the 300 port. After setting up the Adguard Home, it will try to redirect to the 80 port.

2. Update the values file to set the ingress port to 80:
   
3. Now you can test that the DNS is working using the floating IP assigned by MetalLB. You can use the following command to test DNS resolution:
   ```bash
   nslookup github.com <IP_ADDRESS>
   ```
4. And you can try to resolve a domain that is blocked by AdGuard Home:
   ```bash
   nslookup doubleclick.net <IP_ADDRESS>
   ```
   