# Home Assistant


## Connect the Zigbee Sonoff Zigbee 3.0 Dongle Plus

Download the latest driver from https://www.silabs.com/developer-tools/usb-to-uart-bridge-vcp-drivers?tab=downloads

After the installation, look for the device in MacOS:
```shell
ls /dev/* | grep UART
```

Install ser2net in the macOS:
```shell
brew install ser2net
brew services start ser2net
sudo ln -s /usr/local/sbin/ser2net /usr/local/bin/ser2net
```

Add this to the `/usr/local/etc/ser2net/ser2net.yaml` file:
```
connection: &zigbee
  accepter: tcp,12345
  connector: serialdev,/dev/tty.SLAB_USBtoUART,115200n81,local
  options:
    kickolduser: true
    banner: false
```

Then restart the ser2net service:
```shell
brew services restart ser2net
```

This will expose the Zigbee dongle on port 12345, which can be used by Home Assistant. Check the logs to ensure that the service is running correctly:
```shell
lsof -iTCP -sTCP:LISTEN -n -P | grep 12345
```

or
```shell
nc -v localhost 12345
```

Now you need to configure lima to use the ser2net service. First install socat in the lima instance:
```shell
sudo apt update
sudo apt install -y socat
```

Then use socat to create a virtual device:
```shell
sudo socat -d -d pty,raw,echo=0,link=/dev/ttyUSB0 tcp:host.lima.internal:12345
```

You should see the device in /dev:
```shell
ls -l /dev/ttyUSB0
```

And it should look like this:
```shell
lrwxrwxrwx 1 root root 10 Jun  8 00:15 /dev/ttyUSB0 -> /dev/pts/2
```

Now let's automate the socat command by creating a systemd service. Create a file named `/etc/systemd/system/socat-serial.service` with the following content:

```shell
sudo nano /etc/systemd/system/zigbee-socat.service
```

And add the following content:

```ini
[Unit]
Description=Socat Zigbee USB to TCP via ser2net
After=network.target

[Service]
ExecStart=/usr/bin/socat pty,raw,echo=0,link=/dev/ttyUSB0 tcp:host.lima.internal:12345
Restart=always
RestartSec=5
User=root

[Install]
WantedBy=multi-user.target
```

Reload systemd and enable the service:

```shell
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable zigbee-socat
sudo systemctl start zigbee-socat
```

Check that it's running:

```shell
sudo systemctl status zigbee-socat
ls -l /dev/ttyUSB0
```

