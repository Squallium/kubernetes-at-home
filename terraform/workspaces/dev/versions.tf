terraform {
  required_providers {
    authentik = {
      source  = "goauthentik/authentik"
      version = "~> 2025.8.1"
    }
  }

  backend "local" {
    path = "../../../secrets/states/dev/terraform.tfstate"
  }
}
