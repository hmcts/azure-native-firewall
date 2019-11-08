terraform {
  required_version = ">= 0.11.0"
}

provider "azurerm" {
  alias           = "aks"
  subscription_id = "b72ab7b7-723f-4b18-b6f6-03b0f2c6a1bb"
}