resource "azurerm_public_ip" "main" {
  name                = "fw-${var.location}-${var.environment}-pip"
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "firewall-${var.environment}"

  tags = var.common_tags
}