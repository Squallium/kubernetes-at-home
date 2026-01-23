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

  logout_uri = "${each.value.domain_name}${each.value.logout_uri_suffix}"
  signing_key            = var.authentik_signing_key
  property_mappings       = var.authentik_property_mappings
}


resource "authentik_application" "oidc_apps" {
  for_each = var.standard_oidc_services

  name              = each.value.name
  slug              = each.key
  group             = each.value.group
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/${each.key}.png"
  meta_launch_url   = coalesce(each.value.meta_launch_url, "${each.value.domain_name}/")
  open_in_new_tab   = true
  protocol_provider = authentik_provider_oauth2.oidc_providers[each.key].id
}

resource "authentik_application" "non_oidc_apps" {
  for_each = var.non_oidc_services

  name            = each.value.name
  slug            = each.key
  group           = each.value.group
  meta_icon       = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/${each.key}${each.value.icon_theme}.png"
  meta_launch_url = each.value.domain_name
  open_in_new_tab = true
}
