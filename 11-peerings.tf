//resource "azurerm_virtual_network_peering" "hub_to_aks" {
//  count                        = lookup(var.peering_setup, "subscription", "") == "" ? 0 : 1
//  name                         = "hub_to_aks"
//  resource_group_name          = data.azurerm_virtual_network.hub_vnet.name
//  virtual_network_name         = data.azurerm_virtual_network.hub_vnet.name
//  remote_virtual_network_id    = data.azurerm_virtual_network.aks[0].id
//  allow_virtual_network_access = true
//}
//
//resource "azurerm_virtual_network_peering" "aks_to_hub" {
//  count                        = lookup(var.peering_setup, "subscription", "") == "" ? 0 : 1
//  provider                     = azurerm.aks
//  name                         = "aks_to_hub"
//  resource_group_name          = data.azurerm_virtual_network.aks[0].resource_group_name
//  virtual_network_name         = data.azurerm_virtual_network.aks[0].name
//  remote_virtual_network_id    = data.azurerm_virtual_network.hub_vnet.id
//  allow_virtual_network_access = true
//}