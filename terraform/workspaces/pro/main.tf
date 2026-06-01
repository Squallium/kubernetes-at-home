module "k8s-at-home-common" {
  source = "../../modules/k8s-at-home-common"

  standard_oidc_services = {
    vikunja = {
      name        = "Vikunja"
      group       = "Organización"
      domain_name = "https://vikunja.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
      client_id   = "4S14myjUOBF1gu1gB3XtxCMltNsg8rr0luexLdgM"
    }
    warracker = {
      name        = "Warracker"
      group       = "Inventario"
      domain_name = "https://warracker.internal"
      redirect_uri_suffix = "/api/oidc/callback"
      logout_uri_suffix = ""
      client_id   = "V9N1XYYt6ejMFCTkg28O4NKfY9Hewd9mp4ooOif1"
    }
    paperless = {
      name        = "Paperless"
      group       = "Inventario"
      domain_name = "https://paperless.internal"
      redirect_uri_suffix = "/accounts/oidc/authentik/login/callback/"
      logout_uri_suffix = "/application/o/paperless/end-session/"
      client_id   = "W518HnjYJYoPmFpHpmpRV1BgDBgGXYFUaWyEalx9LFSCMXkD"
    }
    home-assistant = {
      name        = "Home Assistant"
      group       = "Domótica"
      domain_name = "https://home-assistant.internal.org"
      meta_launch_url = "https://home-assistant.internal.org/auth/oidc/welcome"
      redirect_uri_suffix = "/auth/oidc/callback"
      logout_uri_suffix = "/auth/logout/"
      client_id   = "M1oz8Z1CyWUarzadq4EMhyrZJaBZy1G_F7cxzVXr7uI"
    }
  }

  non_oidc_services = {
    pgbackweb = {
      name        = "pgBackWeb"
      group       = "Backup & DR"
      icon_theme = "-light"
      domain_name = "https://pgbackweb.internal"
    }
    zigbee2mqtt = {
      name        = "Zigbee2MQTT"
      group       = "Domótica"
      domain_name = "https://zigbee2mqtt.internal"
    }
  }

}

