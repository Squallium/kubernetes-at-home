# increasing timeout for big uploads

```bash
kubectl -n ingress patch daemonset traefik --type='json' -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--entryPoints.websecure.transport.respondingTimeouts.readTimeout=10m"}]'
```

then restart the daemonset:

```bash
kubectl -n ingress rollout restart daemonset traefik
```