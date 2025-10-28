variable "authentik_invalidation_flow" {
    description = "The invalidation flow ID for Authentik OAuth2 providers"
    type        = string
}

variable "authentik_signing_key" {
    description = "The signing key for Authentik OAuth2 providers"
    type        = string
}

variable "authentik_property_mappings" {
  description = "The property mappings for Authentik OAuth2 providers"
  type        = list(string)
}

variable "vikunja_meta_launch_url" {
  description = "The launch URL for Vikunja application in Authentik"
  type        = string
}

variable "vikunja_allowed_redirect_uri" {
  description = "The allowed redirect URI for Vikunja OAuth2 provider in Authentik"
  type        = string
}

variable "vikunja_backchannel_logout_uri" {
  description = "The backchannel logout URI for Vikunja OAuth2 provider in Authentik"
  type        = string
}

variable "vikunja_client_id" {
  description = "The client ID for Vikunja OAuth2 provider in Authentik"
  type        = string
}
