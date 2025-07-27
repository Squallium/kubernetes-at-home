## Securing the Admin Account

By creating a hashed password and signing key

```bash
pass=$(openssl rand -base64 48 | tr -d "=+/" | head -c 32)
echo "Password: $pass"
hashed_pass=$(htpasswd -bnBC 10 "" $pass | tr -d ':\n')
echo "Password Hash: $hashed_pass"
echo "Encoded Password Hash: $(echo -n "$hashed_pass" | base64)"
signing_key=$(openssl rand -base64 48 | tr -d "=+/" | head -c 32)
echo "Signing Key: $signing_key"
echo "Encoded Signing Key: $(echo -n "$signing_key" | base64)"
```

Then we have to create a secret using the external secret operator with this structure:

```yaml
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: <secret name>
  namespace: <kargo namespace>
data:
  ADMIN_ACCOUNT_TOKEN_SIGNING_KEY: <base64 encoded signing key>
  ADMIN_ACCOUNT_PASSWORD_HASH: <base64 encoded bcrypt-hashed password>
```