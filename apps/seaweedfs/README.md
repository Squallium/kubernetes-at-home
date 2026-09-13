# Installing on ubuntu
```bash
curl -fsSL https://raw.githubusercontent.com/seaweedfs/seaweedfs/master/install.sh | sudo bash
weed version
sudo AWS_ACCESS_KEY_ID=admin AWS_SECRET_ACCESS_KEY='<LONG_KEY>' S3_BUCKET=velero weed mini -dir=/mnt/services/seaweedfs
```

Now you can test the installation by running the following command:

```bash
$env:AWS_ACCESS_KEY_ID="admin" 
$env:AWS_SECRET_ACCESS_KEY="<LONG_KEY>"
$env:S3_BUCKET="velero"
aws s3 ls --endpoint-url http://192.168.1.166:8333    
```

Now you can try to upload and download a file using the following commands:

```bash
"Hola desde Windows" | Set-Content prueba-seaweedfs.txt         
aws s3 cp .\prueba-seaweedfs.txt s3://velero/prueba-seaweedfs.txt --endpoint-url http://192.168.1.166:8333 
aws s3 cp s3://velero/prueba-seaweedfs.txt .\prueba-descargada.txt --endpoint-url http://192.168.1.166:8333  
Get-Content .\prueba-descargada.txt
```



And now we need to configure a systemd service to run the seaweedfs server in the background. First we create a file
for storing the secrets apart from the ini file:

```bash
sudo mkdir -p /etc/seaweedfs
sudo nano /etc/seaweedfs/seaweedfs.env
sudo chmod 600 /etc/seaweedfs/seaweedfs.env
```

Now we create a systemd service file:

```bash
sudo nano /etc/systemd/system/seaweedfs.service
```

With the following content:

```ini
[Unit]
Description=SeaweedFS Mini S3 Object Storage
Documentation=https://github.com/seaweedfs/seaweedfs
Wants=network-online.target
After=network-online.target
RequiresMountsFor=/mnt/services/seaweedfs

[Service]
Type=simple
User=kuber
Group=kuber
EnvironmentFile=/etc/seaweedfs/seaweedfs.env
ExecStart=/usr/local/bin/weed mini -dir=/mnt/services/seaweedfs
Restart=on-failure
RestartSec=10

# Permitir que el proceso cree suficientes ficheros
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

Enable and start the service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable seaweedfs.service
sudo systemctl start seaweedfs.service
```
check the status of the service:

```bash
sudo systemctl status seaweedfs --no-pager
```

Check the logs of the service:

```bash
sudo journalctl -u seaweedfs -n 80 --no-pager
```
