### 

After applying configurations CoreDNS deploy needs to be restarted to pick up the changes:
```bash
kubectl -n kube-system rollout restart deployment coredns
```