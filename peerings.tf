data "azurerm_virtual_network" "aks" {
  count               = length(var.aks_config)
  name                = lookup(var.aks_config[count.index], "vnet_name")
  resource_group_name = lookup(var.aks_config[count.index], "rg_name")
}

data "azurerm_virtual_network" "hub-vnet" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network_peering" "hub_to_aks" {
  count                        = length(var.aks_config)
  name                         = "hub_to_${lookup(var.common_tags, "activityName")}"
  resource_group_name          = var.rg_name
  virtual_network_name         = var.vnet_name
  remote_virtual_network_id    = data.azurerm_virtual_network.aks[count.index].id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "aks_to_hub" {
  count                        = length(var.aks_config)
  name                         = "${lookup(var.common_tags, "activityName")}_to_hub"
  resource_group_name          = data.azurerm_virtual_network.aks[count.index].resource_group_name
  virtual_network_name         = data.azurerm_virtual_network.aks[count.index].name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub-vnet.id
  allow_virtual_network_access = true
}
