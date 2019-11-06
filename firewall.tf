resource "azurerm_firewall" "main" {
  name                = "${var.environment}-${var.location}-fw"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = var.aks_config[0]
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.main[0].id
  }

  tags = var.common_tags
}