terraform {
  required_version = ">= 0.11.0"
  backend "azurerm" {}
}

provider "azurerm" {
  version         = ">=1.24.0"
  subscription_id = "${var.subscription_id}"
}

provider "azurerm" {
  alias           = "aks"
  subscription_id = lookup(var.peering_setup, "subscription", "")
}