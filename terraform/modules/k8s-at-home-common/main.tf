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
  group             = "Organization"
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
  group             = "Inventory"
  meta_icon         = "https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/png/warracker.png"
  meta_launch_url   = var.warracker_domain_name
  open_in_new_tab   = true
  protocol_provider = authentik_provider_oauth2.provider_for_warracker.id
}