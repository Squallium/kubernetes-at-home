## v1.0.0 (2025-07-13)

### Feat

- **apps/cert-manager**: added configuration for cert-manager in dev
- **apps/adguard-home**: added ssl support in dev
- **apps/kube-prometheus-stack**: added ssl support
- **apps/minio**: added ssl support
- **apps/argocd**: additional configuration for enabling ssl in argocd
- **apps/vault**: split ssl configuration
- **apps/cert-manager**: added certificates for argocd, grafana and minio
- **apps/vault**: enable ssl with a self signed certificate
- **charts/cert-manager-config**: added certificates and parametrization
- **charts/cert-manager-config**: added cluster issuer
- **charts/cert-manager-config**: added chart for cert manager configuration resources
- **apps/cert-manager**: installing cert-manager in all clusters
- **core**: installing cert manager
- **charts/calibre-web**: added new chart for deploying calibre web
- **apps/loki**: enable ingress for gateway
- **charts/loki-config**: added external secrets for loki
- **apps/loki**: set storage configuration pointing to minio
- **charts/minio-config**: adding a new chart for minio additional resources
- **apps/minio**: adding minio at core leve to be share between environments
- **apps/promtail**: adding promtail to send logs to loki
- **apps/loki**: deploying loki without the rest of the stack
- **apps/loki-stack**: enable promtail for in cluster
- **apps/kube-prometheus-stack**: added loki as grafana source
- **templates**: added new section for adding core services like prometheus or loki stacks
- **apps/adguard-home**: enable it in production
- **apps/home-assistant-addons**: enable production
- **apps/home-assistant**: enable production environment
- **templates**: added non environment values.yaml to share config values between environment
- **gitops**: start using helm charts insetad of paths
- **workflows**: added default workflow form chart releaser readme to check if its working
- **charts/adguard-home**: added adguard-home chart that works with metallb service
- **charts/home-assistant-config**: added hacs installation as cronjob
- **apps/home-assistant-addons**: enable ingress for zigbee2mqtt
- **charts/home-assistant-addons**: added app of apps chart for ha addons with its own chart
- **charts/home-assistant-config**: added official zigbee2mqtt chart
- **charts/home-assistant-config**: added zigbee2mqtt addon
- **charts/home-assistant-config**: added mosquitto broker
- **charts/home-assistant-config**: added chart for additional home assistant configurations
- **apps/home-assistant**: mounted zigbee usb as ser2net in mac and with socat inside lima as usb
- **apps/home-assistant**: added hacs installation as init container
- **apps/home-assistant**: enable ingress in dev
- **gitops**: added home assistant with no customization
- **templates**: added basic non functiona cookiecutter for gitops
- **charts/homebox**: added hostpath volume
- **gitops**: temporary disable adguard
- **charts/adguard-home**: added basic chart for deploying adguard-home
- **charts/paperless-ngx**: updated mount paths
- **apps/paperless-ngx**: deploy in development
- **apps/argocd**: bump config chart version
- **gitops**: setting up an applicationset for homebox
- **addons/external-secrets**: swtich from token to approle vault auth method
- **apps/argocd**: added dev cluster into argocd as secrte mounted by external secrets addon via vault
- **core**: updated documentation
- **apps/minio**: istalling minio for having s3 locally
- **charts/paperless-ngx**: increasing body size in the ingress
- **charts/paperless-ngx**: added volumen for media to avoid losing miniatures
- **charts/paperless-ngx**: exposing volumes to avoid lossing data after restart cluster
- **charts**: added chart for deploying paperless-ngx
- **charts**: added custom chart for homebox
- **gitops**: added argocd apps helm chart in preview
- **apps/argocd**: added initial app pointed to main branch
- **addons**: installed and tested external secrets operator with vault
- **apps**: installed vault and default argocd without configuration
- **core**: setup lima and microk8s in macos and test ingress addon

### Fix

- **charts/cert-manager-config**: added namespace customization
- **charts/cert-manager-config**: wrong api version for external secret resource
- **charts/calibre-web**: change deafult port to http
- **apps/loki**: using vault secrets for secrets
- **apps/minio**: enable minio with existing claim
- **apps/minio**: setting up first the config resources
- **apps/loki-stack**: disable loki-stack because is not exposing all setting for loki
- **gitops**: pointing adguard to a temporary branch to avoid noise
- **charts/adguard-home**: exposing 53 and 3000 via 80
- **charts/adguard-home**: exposing pod ip to the external network
- **charts/adguard-home**: default ingress class name to public
- **core**: point feature branch to main
- **apps/minio**: enable console ingress
- **charts/paperless-ngx**: avoid volume to be recreated
- **core**: replace local.lan by local to avoid errors with router dns
- **charts/homebox**: wrong persistent volume storage class
- **apps/argocd**: escape variable to be evaluated by argocd

### Refactor

- **docs**: reorder documentation
