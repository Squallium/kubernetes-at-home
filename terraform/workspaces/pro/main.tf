module "k8s-at-home-common" {
  source = "../../modules/k8s-at-home-common"

  # authentik
  authentik_invalidation_flow = "ca757b31-d544-41c4-a90e-3d02a387201f"
  authentik_signing_key = "c7d59eb6-f9f7-4aef-b323-46375c6de137"
  authentik_property_mappings = [
    "00409795-f158-4192-ba9b-1224db4ad5d5",
    "d0d24034-b762-402e-bbf0-4d578122a3da",
    "6886467d-5948-4191-b267-2e8a6788680f"
  ]

  # vikunja
  vikunja_domain_name = "https://vikunja.internal"
  vikunja_client_id = "4S14myjUOBF1gu1gB3XtxCMltNsg8rr0luexLdgM"

  # warracker
  warracker_domain_name = "https://warracker.internal"
  warracker_client_id = "V9N1XYYt6ejMFCTkg28O4NKfY9Hewd9mp4ooOif1"

  standard_oidc_services = {
    paperless = {
      name        = "Paperless"
      domain_name = "https://paperless.internal"
      redirect_uri_suffix = "/accounts/oidc/authentik/login/callback/"
      logout_uri_suffix = "/application/o/paperless/end-session/"
      client_id   = "W518HnjYJYoPmFpHpmpRV1BgDBgGXYFUaWyEalx9LFSCMXkD"
    }
  }
}


