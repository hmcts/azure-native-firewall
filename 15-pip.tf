resource "azurerm_public_ip" "primary" {
  name                = "fw-${var.location}-${var.environment}-primary-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "firewall-${var.environment}-primary"

  tags = var.common_tags
}

resource "azurerm_public_ip" "main" {
  count               = length(var.aks_config)
  name                = "fw-${var.location}-${var.environment}-${var.aks_config[count.index]}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "firewall-${var.environment}-${var.aks_config[count.index]}"

  tags = var.common_tags
}