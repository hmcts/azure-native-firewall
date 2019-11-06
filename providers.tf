provider "azurerm" {
    alias        = "aks"
    subscription = lookup(var.peering_setup, "subscription")
}