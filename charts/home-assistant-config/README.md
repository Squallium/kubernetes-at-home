# Home Assistant Config Chart

This chart deploys a Home Assistant configuration using a ConfigMap to store the configuration files. It is designed to be used with a persistent volume to ensure that the configuration is retained across pod restarts. And additional addons.

## Current Features

- Persistent volume for configuration files

## Current Addons

- [Mosquitto Broker](https://github.com/eclipse-mosquitto/mosquitto)
- [Zigbee2MQTT](https://github.com/Koenkk/zigbee2mqtt)