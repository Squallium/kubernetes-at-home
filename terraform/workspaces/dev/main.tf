module "k8s-at-home-common" {
  source = "../../modules/k8s-at-home-common"

  # authentik
  authentik_invalidation_flow = "4a862068-c1c2-4909-b8f2-ce2c8d91a441"
  authentik_signing_key = "87a42c60-f7d2-47df-993d-a0441840f30f"
  authentik_property_mappings = [
    "596bba79-04c9-4a18-820e-bc2d262a654f",
    "ccf67a8b-bbb2-443c-a440-a896ac64f640",
    "1ff3a3d8-56ba-4494-a637-92242f2500b1"
  ]

  # vikunja
  vikunja_domain_name = "https://vikunja-dev.internal"
  vikunja_client_id = "oOJdgBUOw1jA2luNHhb2kZGCfjkRuGC44whmEhfv"

  # warracker
  warracker_domain_name = "https://warracker-dev.internal"
  warracker_client_id = "mxvp0Bc2Kxu5EgdOuhp0MDdNpJmjeb5rsPm0xYoz"
}

