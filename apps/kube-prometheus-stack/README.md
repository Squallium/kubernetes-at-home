## Export Mac host machine metrics with node exporter

First we need to install node exporter on the host machine, for that we can use brew:

```bash
brew install node-exporter
```

Check that is working by accessing to http://localhost:9100/metrics and outside the machine with http://<your-machine-ip>:9100/metrics

Now you have to add the scrap config in the values yaml (check the file apps/kube-prometheus-stack/values.yaml) and finally we can add the grafana dashboard following these steps:

1. Access to the grafana dashboard http://grafana.internal (admin/admin)
2. Go to the "+" icon on the left sidebar and select "Import"
3. In the "Import via grafana.com" field, enter the dashboard ID `1860` (Node Exporter Full) and click "Load"
4. In the next screen, select the Prometheus data source and click "Import"
5. You should now see the Node Exporter Full dashboard with metrics from your Mac host machine