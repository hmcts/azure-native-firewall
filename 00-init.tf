terraform {
  required_version = ">= 0.11.0"
  backend "azurerm" {}
}

provider "azurerm" {
  version         = ">=1.24.0"
}

provider "azurerm" {
  alias           = "aks"
  subscription_id = lookup(var.peering_setup, "subscription", "")
}