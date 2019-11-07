data "azurerm_log_analytics_workspace" "main" {
  name                = "hmcts-dmz-${var.environment}-law"
  resource_group_name = var.rg_name
}

data "azurerm_monitor_diagnostic_categories" "diagnostic_categories" {
  resource_id = azurerm_firewall.main.id
}
