resource "azurerm_firewall" "main" {
  name                = "${var.environment}-${var.location}-${var.aks_config}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = lookup(var.common_tags, "activityName")
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = var.common_tags
}