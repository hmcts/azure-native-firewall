resource "azurerm_firewall" "main" {
  count               = length(var.aks_config)
  name                = "${var.environment}-${var.location}-${lookup(var.aks_config[count.index], "aks_env")}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = lookup(var.common_tags, "activityName")
    subnet_id            = var.subnet_id
    public_ip_address_id = azurerm_public_ip.main[count.index].id
  }

  tags = var.common_tags
}