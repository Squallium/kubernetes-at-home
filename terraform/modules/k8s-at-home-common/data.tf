data "vault_kv_secret_v2" "google_oauth" {
  mount = "secret"
  name  = "authentik/${var.environment}/google"
}

data "authentik_flow" "source_authentication" {
  slug = "default-source-authentication"
}

data "authentik_flow" "source_enrollment" {
  slug = "default-source-enrollment"
}

data "authentik_flow" "default-authorization-flow" {
  slug = "default-provider-authorization-implicit-consent"
}

data "authentik_flow" "default-invalidation-flow" {
  slug = "default-invalidation-flow"
}