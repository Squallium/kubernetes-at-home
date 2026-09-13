Update the default storage class to use OpenEBS as the default storage provider in your Kubernetes cluster. This will allow you to create persistent volumes using OpenEBS without specifying a storage class in your PersistentVolumeClaim (PVC) definitions.

You should first remove the default from hostpath storage class and then set the default to OpenEBS. You can do this by running the following commands:

```bash
kubectl patch storageclass microk8s-hostpath -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'
```

then set the default to OpenEBS:

```bash
kubectl patch storageclass openebs-hostpath -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
```

Check the default storage class by running:

```bash
kubectl get storageclass
```
