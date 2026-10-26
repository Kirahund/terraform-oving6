module "network" {
  source              = "../modules/network"
  project             = var.project
  location            = var.location
  resource_group_name = var.resource_group_name
}

# DEL E: Aktiver denne blokken ETTER at begge miljøer er opprettet i del D.

resource "random_password" "demo" {
  length  = 24
  special = true
}