terraform {
  required_providers {
    azurerm = { source = "hashicorp/azurerm", version = "~> 4.0" }
    random  = { source = "hashicorp/random", version = "~> 3.0" }
  }
  backend "azurerm" {
    }
  }
provider "azurerm" {
  features {}
}
locals { name_prefix = "${var.student_id}-${var.project}" }
resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}
module "stack" {
  source              = "../../stacks"
  project             = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}
