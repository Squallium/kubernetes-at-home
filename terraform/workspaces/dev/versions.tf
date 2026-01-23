terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "2025.12.0"
    }
  }

  backend "local" {
    path = "../../../secrets/states/dev/terraform.tfstate"
  }
}
