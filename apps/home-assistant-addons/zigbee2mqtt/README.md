minicom -D /dev/tty.SLAB_USBtoUART -b 115200


nano /usr/local/etc/ser2net/ser2net.yaml



connection: &zigbee
accepter: tcp,55000
connector: serialdev,/dev/tty.SLAB_USBtoUART,115200n81,local
options:
kickolduser: true
banner: false


brew services restart ser2net



➜  ~ brew services list

➜  ~ lsof -iTCP:55000 -sTCP:LISTEN

Inside the lima VM

telnet 192.168.1.183 55000

