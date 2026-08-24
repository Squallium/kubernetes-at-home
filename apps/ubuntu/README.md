- Hemos instalado ubuntu

1- Installin OpenSSH Server

```bash
sudo apt update
sudo apt install openssh-server -y
```



and check the status of the service

```bash
sudo systemctl status ssh
```

2.- Install zsh y oh-my-zsh

```bash
sudo apt update
sudo apt install curl wget unzip zip git tree nano jq -y
sudo apt install zsh -y
```

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

Instalamos los addons de microk8s

```bash
microk8s enable cert-manager 
microk8s enable hostpath-storage 
microk8s enable ingress 
microk8s enable metrics-server
```

# install tailscale a register the cluster in tai

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
```

Configure tailscale for waiting for the ip address to be assigned

```bash
sudo systemctl edit tailscaled
```

Add the following lines

```ini
[Unit]
Wants=network-online.target
After=network-online.target
```

Then reload the systemd daemon and restart tailscaled

```bash
sudo systemctl daemon-reload
sudo systemctl restart tailscaled
```

# registrar el cluster en argocd creando un secreto de cluster

Para ello necesitamos sacar el token de microk8s y el certificado del cluster

```bash
microk8s config
```

Y lo copiamos en el secreto del vault y en el kubeconfig




# hay que configurar el dns para que sepa encontrar el vault

# crear manualmente el approle de vault

# necesitamos el external secrets para cargar secretos desde vault

# a continuación el cert manager para los certificados

# luego ya podemos emepzar a desplegar aplicaciones


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





