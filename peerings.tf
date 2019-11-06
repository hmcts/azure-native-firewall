data "azurerm_virtual_network" "aks" {
  provider            = azurerm.aks
  name                = "core-${lookup(var.peering_setup, "env")}-vnet"
  resource_group_name = "aks-infra-${lookup(var.peering_setup, "env")}-rg"
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network_peering" "hub_to_aks" {
  name                         = "hub_to_${lookup(var.common_tags, "activityName")}"
  resource_group_name          = data.azurerm_virtual_network.hub_vnet.name
  virtual_network_name         = data.azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id    = data.azurerm_virtual_network.aks.id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "aks_to_hub" {
  name                         = "${lookup(var.common_tags, "activityName")}_to_hub"
  resource_group_name          = data.azurerm_virtual_network.aks.resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.aks.name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub_vnet.id
  allow_virtual_network_access = true
}