import {
  id = 1
  to = module.k8s-at-home-common.authentik_provider_oauth2.provider_for_vikunja
}

import {
  id = "vikunja"
  to = module.k8s-at-home-common.authentik_application.vikunja
}

# import {
#   id = 6
#   to = module.k8s-at-home-common.authentik_provider_oauth2.provider_for_warracker
# }
#
# import {
#   id = "warracker"
#   to = module.k8s-at-home-common.authentik_application.warracker
# }