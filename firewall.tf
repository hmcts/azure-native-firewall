resource "azurerm_firewall" "main" {
  name                = "${var.environment}-${var.location}-fw"
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "ip_configuration" {
    iterator = config
    for_each = var.aks_config

    content {
      name                 = config.value
      subnet_id            = var.subnet_id
      public_ip_address_id = azurerm_public_ip.main[config.key].id
    }

  }

  tags = var.common_tags
}