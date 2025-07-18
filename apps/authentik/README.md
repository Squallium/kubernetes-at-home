# Reset akadmin password

# Access to 

```bash
kubectl exec -it deploy/authentik-worker -n <namespace> -- bash
```

# access to the authentik shell
```bash
ak shell
```

# reset the password
```bash
from authentik.core.models import User
u = User.objects.get(username="akadmin")
u.set_password("NuevaPasswordSegura123!")
u.save()
```

