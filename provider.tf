provider "azurerm" {
  alias           = "aks"
  subscription_id = lookup(var.aks_config, "subscription")
}