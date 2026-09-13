Manual creation of the secret

First create the secret file with the credentials for Velero to access the S3 storage. Create a file named `velero.ini` with the following content:

```ini
[default]
aws_access_key_id=admin
aws_secret_access_key=TU_SECRET_REAL
```

then execute the following command to create the secret in the `velero` namespace:

```bash
kubectl -n velero create secret generic velero-s3-credentials --from-file=cloud="<path_to_your_velero.ini_file>"
```
