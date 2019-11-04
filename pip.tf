resource "azurerm_public_ip" "main" {
  count               = length(var.aks_config)
  name                = "fw-${var.location}-${var.environment}-${lookup(var.aks_config[count.index], "aks_env")}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "firewall-${var.environment}-${lookup(var.aks_config[count.index], "aks_env")}"

  tags = var.common_tags
}