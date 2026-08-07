- Hemos instalado ubuntu
- Despuesd enchufar la antena hemos ejecutado el comando

```bash
dmesg | tail -30
```

Para comprobar que el sistema ha reconocido la antena y ha cargado los drivers correspondientes. Deberíamos ver mensajes relacionados con la detección del dispositivo y la asignación de recursos.

"cp210x converter now attached to ttyUSB0"

En nuestro caso ha sido 

Y luego hemos hecho un 

```bash
lsusb
```

Silicon Labs CP210x USB to UART Bridge

Ahora par ver que le ponemos al Zigbee2mqtt, hemos hecho un 

```bash
ls -l /dev/serial/by-id
``` 

y evitamos probemas de cambio de puerto



ahora utilidades instaladas:

```bash
sudo apt update
sudo apt install -y \
curl \
git \
nano \
jq \
tree \
unzip \
zip
```

y ahora ocn snap el microk8s

```bash
sudo snap install microk8s --classic
```

damos permisos a microk8s para que pueda ejecutar comandos sin sudo

```bash
sudo usermod -a -G microk8s $USER
mkdir -p ~/.kube
sudo chown -R $USER ~/.kube
```

Y luego cerramos sessión yc omprobamos que funciona el version

```bash
microk8s version
```

Siguientes pasos:

# registrar el cluster en argocd creand un secreto de cluster

# hay que configurar el dns para que sepa encontrar el vault

# necesitamos el external secrets para cargar secretos desde vault





