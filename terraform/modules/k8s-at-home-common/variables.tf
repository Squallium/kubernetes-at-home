variable "standard_oidc_services" {
  description = "A map of standard OIDC services with their respective domain names and optional client IDs"
  type = map(object({
    name       = string
    group      = optional(string, "Organización")
    description = optional(string, "")
    icon_name   = optional(string)
    icon_theme  = optional(string, "")
    icon_url    = optional(string)
    domain_name = string
    meta_launch_url = optional(string)
    redirect_uri_suffix = string
    logout_uri_suffix = string
    client_id  = optional(string)
  }))
  default = {}
}

variable "non_oidc_services" {
    description = "A map of non-OIDC services with their respective domain names"
    type = map(object({
        name        = string
        group       = optional(string, "Organización")
        description = optional(string, "")
        icon_name   = optional(string)
        icon_theme  = optional(string, "")
        icon_url    = optional(string)
        domain_name = string
    }))
    default = {}
}
