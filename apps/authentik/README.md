# Setting up authentik

## create new cert authority

# create a new directory for the CA
```shell
mkdir -p ~/my-ca && cd ~/my-ca
```

# create a new private key for the CA
```shell
openssl genrsa -out rootCA.key 4096
```

# root certificate self-signed (valid for 10 years)
```shell
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt -subj "/C=ES/ST=Home/O=MyClusterCA/CN=mycluster-ca"
```