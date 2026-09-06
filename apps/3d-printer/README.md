# check where is the printer in the USB 
```bash
lsusb
ls /dev/tty*
ls /dev/serial/by-id/
```

# Install ser2net for testing the printer
```bash
sudo apt update
```

If the apt fails you can reset the apt cache and try again
```bash
sudo rm -rf /var/lib/apt/lists/*
sudo apt update
```

Install ser2net
```bash
sudo apt install ser2net
```

Add the following lines to the ser2net.yaml

```bash
sudo nano /etc/ser2net.yaml
```

```yaml
connection: &kobra
  accepter: tcp,0.0.0.0,3333
  enable: on
  options:
    kickolduser: true
    telnet-brk-on-sync: true
  connector: serialdev,
    /dev/serial/by-id/usb-1a86_USB_Serial-if00-port0,
    115200n81,local
```

Validate the yaml with

```bash
sudo ser2net -c /etc/ser2net.yaml -n -d
```

Restart the ser2net service

```bash
sudo systemctl status ser2net
sudo systemctl restart ser2net
```

Now test the connection from other machine with the ip address of the machine running ser2net and the port 3333

```bash
telnet <ip-address> 3333
Test-NetConnection <ip-address> -Port 3333
```


# Setup and configure webcam streaming for raspberry Pi

Identify the webcam device

```bash
v4l2-ctl --list-devices
```

Once appear as camera you need to find the identifier of the camera, for example:

```bash
ls -l /dev/v4l/by-id/
```

If you have multiple indexes you need to find the one that is the camera, for example:

```bash
v4l2-ctl -d /dev/v4l/by-id/<identifier> --list-formats-ext
```

Now we're going to install https://github.com/pikvm/ustreamer for streaming the webcam to the network

```bash
sudo apt install ustreamer
```

You can temporary test the streaming with the following command

```bash
ustreamer \
  --device=<identifier> \
  --resolution=1280x720 \
  --format=MJPEG \
  --desired-fps=15 \
  --host=0.0.0.0 \
  --port=8080
```

And check the stream with the following url in your browser

```bash
http://<ip-address>:8080/stream
```

Now create a systemd service for ustreamer

```bash
sudo nano /etc/systemd/system/ustreamer.service
```

```ini
[Unit]
Description=USB Webcam MJPEG Streamer
After=network.target

[Service]
ExecStart=/bin/bash -c 'ustreamer --device=$(readlink -f /dev/v4l/by-id/usb-CameraA_CameraA_CameraA-video-index0) --resolution=1280x720 --format=MJPEG --desired-fps=15 --host=0.0.0.0 --port=8080'
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Reload systemd config and check the new service

```bash
sudo systemctl daemon-reload
sudo systemctl start ustreamer
```

Check the status with

```bash
systemctl status ustreamer --no-pager
```

Once you have confirmed that the service is running, enable it to start on boot

```bash
sudo systemctl enable ustreamer
systemctl is-enabled ustreamer
```

# Anycubic Kobra Neo — OctoPrint

## Printer Profile

- **Name:** Anycubic Kobra Neo
- **Identifier:** `_default`
- **Model:** Anycubic Kobra Neo

## Print Bed & Build Volume

- **Form factor:** Rectangular
- **Origin:** Lower Left
- **Heated Bed:** ✅
- **Heated Chamber:** ❌

### Print Volume

| Axis | Value |
|---|---:|
| X / Width | 220 mm |
| Y / Depth | 220 mm |
| Z / Height | 250 mm |

- **Custom bounding box:** ❌

## Axes

Unit: `mm/min`

| Axis | Maximum speed/feedrate | Invert control |
|---|---:|:---:|
| X | 500 | ❌ |
| Y | 500 | ❌ |
| Z | 10 | ❌ |
| E | 25 | ❌ |

## Hotend & Extruder

- **Nozzle diameter:** 0.4 mm
- **Number of extruders:** 1
- **Default extrusion length:** 5 mm


# Octoprint configurations

You need to install the following plugin for remote connecting to the printer https://github.com/mstarostik/OctoPrint-Remote_connection


# Modify offset using Merlin

```bash
M851 Z-1.50
```

Save the settings

```bash
M500
```

Homing the printer

```bash
G28 
``` 

Check the new offset

```bash
G1 Z10 F300
G1 X20 Y20 F3000
G1 Z0.20 F300
```

Check the current settings

```bash
M503
``` 

Check the center of the bed

```bash 
G1 Z1.5 F100
G1 X110 Y110 F3000
G1 Z0.2 F100
```


Check front left 

```bash
G1 Z1.5 F100
G1 X20 Y20 F3000
G1 Z0.2 F100
```

Check front right 

```bash
G1 Z1.5 F100
G1 X200 Y20 F3000
G1 Z0.2 F100
```

Check back left 

```bash
G1 Z1.5 F100
G1 X20 Y200 F3000
G1 Z0.2 F100
```

Check back right 

```bash
G1 Z1.5 F100
G1 X200 Y200 F3000
G1 Z0.2 F100
```

# Connecting to the printer using marlinraker


# follow these steps

sudo systemctl stop ser2net
sudo systemctl status ser2net

node --version
npm --version
cat /etc/os-release

apt-cache policy nodejs
sudo apt update
sudo apt install -y nodejs npm
node --version
npm --version
htop

ls -l /dev/serial/by-id/
ls
cd Software/
ls
clear

git clone https://github.com/phm07/marlinraker.git
cd marlinraker/
ls
cat package.json
clear
ls config
cat config/marlinraker.toml
npm ci
npm run dev


# run the server in dev mode

```bash
npm run dev
```

# check connectivity in other terminal

```bash
curl http://localhost:7125/server/info
```


# build the server for production

```bash
npm run build
```

# create a service for marlinraker

First disable ser2net service

```bash
sudo systemctl disable ser2net
```


```bash
sudo nano /etc/systemd/system/marlinraker.service
```

with the following content

```ini
[Unit]
Description=MarlinRaker
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=kuber
WorkingDirectory=/home/kuber/Software/marlinraker
Environment=NODE_ENV=production
Environment=MARLINRAKER_DIR=/home/kuber/Software/marlinraker/marlinraker_files
ExecStart=/usr/bin/node /home/kuber/Software/marlinraker/dist/index.js
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

Reload systemd config and check the new service

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now marlinraker
```

And check the status with

```bash
sudo systemctl status marlinraker --no-pager
```

Now you can check the connectivity with the following command

```bash
curl http://<your ip>:7125/server/info
```

