resource "azurerm_firewall" "main" {
  name                = "${var.environment}-${var.location}-fw"
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "ip_configuration" {
    iterator = ip_address
    for_each = [for ip_address in azurerm_public_ip.main : {
      public_ip_address_id = ip_address.id
      public_ip_address_name = ip_address.name
    }]

    content {
      name                 = ip_address.value.public_ip_address_name
      public_ip_address_id = ip_address.value.public_ip_address_id
    }
  }

  ip_configuration {
    name                 = "primary"
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.primary.id
  }

  tags = var.common_tags
}