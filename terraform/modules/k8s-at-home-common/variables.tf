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
