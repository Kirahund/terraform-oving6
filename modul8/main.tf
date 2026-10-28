
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

variable "student_id" {
  type = string
}

variable "project" {
  type = string
}

variable "location" {
  type = string
}

locals {
  name_prefix = "${var.student_id}-${var.project}"
}

resource "azurerm_resource_group" "main" {
  name     = "${local.name_prefix}-rg"
  location = var.location
}

module "network" {
  source              = "git::https://github.com/Kirahund/terraform-oving6.git//modules/network?ref=network-v1.1.0"
  project             = local.name_prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

