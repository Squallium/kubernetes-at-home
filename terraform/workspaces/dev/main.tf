module "k8s-at-home-common" {
  source = "../../modules/k8s-at-home-common"

  standard_oidc_services = {
    argo-cd = {
      name        = "Argo CD"
      group       = "Desarrollo"
      domain_name = "https://argocd-dev.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    calibre-web = {
      name        = "Calibre-Web"
      group       = "Libros, manga y comics"
      domain_name = "https://calibre-web-dev.internal"
      redirect_uri_suffix = "/login/generic/authorized"
      logout_uri_suffix = "/auth/oidc/logout"
    }
    home-assistant = {
      name        = "Home Assistant"
      group       = "Domótica"
      domain_name = "https://home-assistant-dev.internal.org"
      meta_launch_url = "https://home-assistant-dev.internal.org/auth/oidc/welcome"
      redirect_uri_suffix = "/auth/oidc/callback"
      logout_uri_suffix = "/auth/logout/"
    }
    homebox = {
      name        = "HomeBox"
      group       = "Inventario"
      domain_name = "https://homebox-dev.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    jellyfin = {
      name        = "Jellyfin"
      group       = "Multimedia"
      domain_name = "https://jellyfin-dev.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    kargo = {
      name        = "Kargo"
      group       = "Desarrollo"
      icon_url    = "https://docs.kargo.io/img/kargo.png"
      domain_name = "https://kargo.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    grafana = {
      name        = "Grafana"
      group       = "Desarrollo"
      domain_name = "https://grafana.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    prometheus = {
      name        = "Prometheus"
      group       = "Desarrollo"
      domain_name = "https://prometheus-dev.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    paperless = {
      name        = "Paperless"
      group       = "Inventario"
      domain_name = "https://paperless-dev.internal"
      redirect_uri_suffix = "/accounts/oidc/authentik/login/callback/"
      logout_uri_suffix = "/application/o/paperless/end-session/"
    }
    romm = {
      name        = "Romm"
      group       = "Videojuegos"
      domain_name = "https://romm-dev.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    vikunja = {
      name        = "Vikunja"
      group       = "Inventario"
      domain_name = "https://vikunja-dev.internal"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    warracker = {
      name        = "Warracker"
      group       = "Inventario"
      domain_name = "https://warracker-dev.internal"
      redirect_uri_suffix = "/api/oidc/callback"
      logout_uri_suffix = ""
    }
  }

  non_oidc_services = {
    adguard-home = {
      name        = "AdGuard Home"
      group       = "Desarrollo"
      description = "DNS privado y bloqueador de anuncios"
      domain_name = "http://192.168.1.157:3000"
    }
    pgbackweb = {
      name        = "pgBackWeb"
      group       = "Desarrollo"
      icon_theme = "-light"
      domain_name = "https://pgbackweb-dev.internal"
    }
    zigbee2mqtt = {
      name        = "Zigbee2MQTT"
      group       = "Domótica"
      domain_name = "https://zigbee2mqtt-dev.internal"
    }
    vault = {
      name        = "Vault"
      group       = "Desarrollo"
      domain_name = "https://vault.internal"
    }
  }
}

