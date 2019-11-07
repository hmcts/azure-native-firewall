data "azurerm_log_analytics_workspace" "main" {
  name                = "hmcts-dmz-${var.environment}-law"
  resource_group_name = var.rg_name
}

data "azurerm_monitor_diagnostic_categories" "diagnostic_categories" {
  resource_id = azurerm_firewall.main.id
}


data "azurerm_virtual_network" "aks" {
  count               = lookup(var.peering_setup,"subscription","") == "" ? 0 : 1
  provider            = azurerm.aks
  name                = "core-${lookup(var.peering_setup, "env")}-vnet"
  resource_group_name = "aks-infra-${lookup(var.peering_setup, "env")}-rg"
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
}