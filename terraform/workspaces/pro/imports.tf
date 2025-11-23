import {
  id = 1
  to = module.k8s-at-home-common.authentik_provider_oauth2.oidc_providers["vikunja"]
}

import {
  id = "vikunja"
  to = module.k8s-at-home-common.authentik_application.oidc_apps["vikunja"]
}

import {
  id = 2
  to = module.k8s-at-home-common.authentik_provider_oauth2.oidc_providers["warracker"]
}

import {
  id = "warracker"
  to = module.k8s-at-home-common.authentik_application.oidc_apps["warracker"]
}