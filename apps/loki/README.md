## Check status

We can do a port forward to the loki service in the 3100
```bash
kubectl port-forward svc/loki 3100:3100 -n loki
```

Then we can check the status of loki by going to `http://localhost:3100/ready` or `http://localhost:3100/health`


## Check logs 

Inside the Grafana pod we can run a query to check response of the validation of the loki service
```bash
curl 'http://loki.loki.svc.cluster.local:3100/loki/api/v1/query?query=rate(%7Bjob%3D~%22.%2B%22%7D%5B5m%5D)'
```

And also another one to check it there are any logs at all:
```bash
curl 'http://loki.loki.svc.cluster.local:3100/loki/api/v1/labels'
```