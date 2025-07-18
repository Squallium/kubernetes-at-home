# Setting up cert-manager

## create new cert authority

# create a new directory for the CA

```shell
mkdir -p ~/my-ca && cd ~/my-ca
```

# Create a ca.conf file with the following content:

```shell
cat > ca.conf <<EOF
[ req ]
default_bits        = 4096
distinguished_name  = req_distinguished_name
x509_extensions     = v3_ca
prompt              = no

[ req_distinguished_name ]
CN = My Internal CA

[ v3_ca ]
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always,issuer
basicConstraints = critical, CA:true
keyUsage = critical, digitalSignature, cRLSign, keyCertSign
EOF
```

# create a new private key for the CA

```shell
openssl genrsa -out rootCA.key 4096
```

# root certificate self-signed (valid for 10 years)

```shell
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt -config rootCA.conf
```

# save the key and the crt files in the vault and create the secret in the cert-manager namespace using the cert-manager-config chart
