resource "authentik_provider_oauth2" "oidc_providers" {
  for_each = var.standard_oidc_services

  name                  = "Provider for ${each.value.name}"
  client_id             = coalesce(each.value.client_id, each.key)
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  invalidation_flow     = var.authentik_invalidation_flow
  access_token_validity = "minutes=5"

  allowed_redirect_uris = [
    {
      matching_mode = "strict"
      url           = "${each.value.domain_name}${each.value.redirect_uri_suffix}"
    }
  ]

  backchannel_logout_uri = "${each.value.domain_name}${each.value.logout_uri_suffix}"
  signing_key            = var.authentik_signing_key
  property_mappings       = var.authentik_property_mappings
}


resource "authentik_application" "oidc_apps" {
  for_each = var.standard_oidc_services

  name              = each.value.name
  slug              = each.key
  group             = each.value.group
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/${each.key}.png"
  meta_launch_url   = "${each.value.domain_name}/"
  open_in_new_tab   = true
  protocol_provider = authentik_provider_oauth2.oidc_providers[each.key].id
}

resource "authentik_provider_oauth2" "provider_for_vikunja" {
  name                  = "Provider for Vikunja"
  client_id             = var.vikunja_client_id
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  invalidation_flow     = var.authentik_invalidation_flow
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      "matching_mode" = "strict"
      "url"           = "${var.vikunja_domain_name}/auth/openid/authentik"
    }
  ]
  backchannel_logout_uri =  "${var.vikunja_domain_name}/auth/openid/authentik"
  signing_key = var.authentik_signing_key
  property_mappings = var.authentik_property_mappings
}

resource "authentik_application" "vikunja" {
  name              = "Vikunja"
  slug              = "vikunja"
  group             = "Organización"
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/vikunja.png"
  meta_launch_url   = "${var.vikunja_domain_name}/"
  open_in_new_tab   = true
  protocol_provider = authentik_provider_oauth2.provider_for_vikunja.id
}

resource "authentik_provider_oauth2" "provider_for_warracker" {
  name                  = "Provider for Warracker"
  client_id             = var.warracker_client_id
  authorization_flow    = data.authentik_flow.default-authorization-flow.id
  invalidation_flow     = var.authentik_invalidation_flow
  access_token_validity = "minutes=5"
  allowed_redirect_uris = [
    {
      "matching_mode" = "strict"
      "url"           = "${var.warracker_domain_name}/api/oidc/callback"
    }
  ]
  backchannel_logout_uri =  var.warracker_domain_name
  signing_key = var.authentik_signing_key
  property_mappings = var.authentik_property_mappings
}

resource "authentik_application" "warracker" {
  name              = "Warracker"
  slug              = "warracker"
  group             = "Inventario"
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/warracker.png"
  meta_launch_url   = var.warracker_domain_name
  open_in_new_tab   = true
  protocol_provider = authentik_provider_oauth2.provider_for_warracker.id
}
