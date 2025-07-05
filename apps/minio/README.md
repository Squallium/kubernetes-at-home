## Configuration

In order to export files into the host system we need to create a pv and pvc, that's why we have the minio-config chart.


## Tests

Once is deployed you can test it with the following command:

```bash
mc alias set localminio http://minio.internal <access_key> <secret_key>
mc ls localminio
mc ls localminio/<bucket_name>
mc cp localminio/<bucket_name>/<file> .
```