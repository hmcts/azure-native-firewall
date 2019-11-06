resource "azurerm_firewall_nat_rule_collection" "main" {
  count               = var.aks_config != "" ? 1 : 0
  name                = "paloDnat"
  azure_firewall_name = azurerm_firewall.main[count.index].name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Dnat"

  dynamic "rule" {
    iterator = rules
    for_each = var.azfw_dnat_rule_palo_lb

    content {
      name = "palo-${rules.value}"

      source_addresses = [
        "*",
      ]

      destination_ports = [
        "80",
      ]

      destination_addresses = [
        azurerm_public_ip.main[count.index].ip_address
      ]

      protocols = [
        "TCP"
      ]

      translated_address = rules.value
      translated_port    = "80"

    }
  }
}