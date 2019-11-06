provider "azurerm" {
    alias           = "aks"
    subscription_id = lookup(var.peering_setup, "subscription","")
}