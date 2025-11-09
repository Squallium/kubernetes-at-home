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

variable "standard_oidc_services" {
  description = "A map of standard OIDC services with their respective domain names and optional client IDs"
  type = map(object({
    name       = string
    group      = optional(string, "Organización")
    domain_name = string
    redirect_uri_suffix = string
    logout_uri_suffix = string
    client_id  = optional(string)
  }))
  default = {}
}


variable "vikunja_domain_name" {
    description = "The domain name for Vikunja application in Authentik"
    type        = string
}

variable "vikunja_client_id" {
  description = "The client ID for Vikunja OAuth2 provider in Authentik"
  type        = string
  default     = null
}

variable "warracker_domain_name" {
    description = "The domain name for Warracker application in Authentik"
    type        = string
}

variable "warracker_client_id" {
    description = "The client ID for Warracker OAuth2 provider in Authentik"
    type        = string
    default     = null
}
