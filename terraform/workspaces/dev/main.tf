module "k8s-at-home-common" {
  source = "../../modules/k8s-at-home-common"

  environment = "development"
  domain_name = var.domain_name

  standard_oidc_services = {
    argo-cd = {
      name        = "Argo CD"
      group       = "Desarrollo"
      subdomain_name = "argocd-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    calibre-web = {
      name        = "Calibre-Web"
      group       = "Libros, manga y comics"
      subdomain_name = "calibre-web-dev"
      redirect_uri_suffix = "/login/generic/authorized"
      logout_uri_suffix = "/auth/oidc/logout"
    }
    home-assistant = {
      name        = "Home Assistant"
      group       = "Domótica"
      subdomain_name = "home-assistant-dev"
      meta_launch_url = "https://home-assistant-dev.${var.domain_name}/auth/oidc/welcome"
      redirect_uri_suffix = "/auth/oidc/callback"
      logout_uri_suffix = "/auth/logout/"
    }
    homebox = {
      name        = "HomeBox"
      group       = "Inventario"
      subdomain_name = "homebox-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    immich = {
      name        = "Immich"
      group       = "Multimedia"
      subdomain_name = "immich-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    jellyfin = {
      name        = "Jellyfin"
      group       = "Multimedia"
      subdomain_name = "jellyfin-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    kargo = {
      name        = "Kargo"
      group       = "Desarrollo"
      icon_url    = "https://docs.kargo.io/img/kargo.png"
      subdomain_name = "kargo"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    grafana = {
      name        = "Grafana"
      group       = "Desarrollo"
      subdomain_name = "grafana"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    prometheus = {
      name        = "Prometheus"
      group       = "Desarrollo"
      subdomain_name = "prometheus-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    paperless = {
      name        = "Paperless"
      group       = "Inventario"
      subdomain_name = "paperless-dev"
      redirect_uri_suffix = "/accounts/oidc/authentik/login/callback/"
      logout_uri_suffix = "/application/o/paperless/end-session/"
    }
    romm = {
      name        = "Romm"
      group       = "Videojuegos"
      subdomain_name = "romm-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
    }
    vikunja = {
      name        = "Vikunja"
      group       = "Inventario"
      subdomain_name = "vikunja-dev"
      redirect_uri_suffix = "/auth/openid/authentik"
      logout_uri_suffix = "/auth/openid/authentik"
      property_mappings = [
        data.authentik_property_mapping_provider_scope.openid.id,
        data.authentik_property_mapping_provider_scope.email.id,
        data.authentik_property_mapping_provider_scope.profile.id,
      ]
      signing_key = data.authentik_certificate_key_pair.default.id
    }
    warracker = {
      name        = "Warracker"
      group       = "Inventario"
      subdomain_name = "warracker-dev"
      redirect_uri_suffix = "/api/oidc/callback"
      logout_uri_suffix = ""
    }
  }

  non_oidc_services = {
    adguard-home = {
      name        = "AdGuard Home"
      group       = "Desarrollo"
      description = "DNS privado y bloqueador de anuncios"
      subdomain_name = "adguard-home"
      meta_launch_url = "http://storm.${var.domain_name}:3000/"
    }
    pgbackweb = {
      name        = "pgBackWeb"
      group       = "Desarrollo"
      icon_theme = "-light"
      subdomain_name = "pgbackweb-dev"
    }
    zigbee2mqtt = {
      name        = "Zigbee2MQTT"
      group       = "Domótica"
      subdomain_name = "zigbee2mqtt-dev"
    }
    vault = {
      name        = "Vault"
      group       = "Desarrollo"
      subdomain_name = "vault"
    }
  }
}

