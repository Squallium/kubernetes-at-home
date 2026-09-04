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