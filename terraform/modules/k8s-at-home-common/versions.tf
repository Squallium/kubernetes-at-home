terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2026.8.2"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "5.13.0"
    }
  }
}
