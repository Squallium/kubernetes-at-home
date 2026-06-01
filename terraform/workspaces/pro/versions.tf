terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2026.2.0"
    }
  }

  backend "local" {
    path = "../../../secrets/states/pro/terraform.tfstate"
  }
}
