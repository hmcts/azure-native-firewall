data "azurerm_log_analytics_workspace" "main" {
  name                = "hmcts-dmz-${var.environment}-law"
  resource_group_name = var.rg_name
}

data "azurerm_monitor_diagnostic_categories" "diagnostic_categories" {
  count       = var.aks_config != "" ? 1 : 0
  resource_id = azurerm_firewall.main[count.index].id
}

resource "azurerm_monitor_diagnostic_setting" "firewall_diagnostics" {
  count                      = var.aks_config != "" ? 1 : 0
  name                       = "fw-log-analytics"
  target_resource_id         = azurerm_firewall.main[count.index].id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.main.id

  dynamic "log" {
    iterator = log
    for_each = [for category in data.azurerm_monitor_diagnostic_categories.diagnostic_categories[count.index].logs : {
      category = category
    }]

    content {
      category = log.value.category
      enabled  = true

      retention_policy {
        enabled = true
      }
    }
  }

  dynamic "metric" {
    iterator = metric
    for_each = [for category in data.azurerm_monitor_diagnostic_categories.diagnostic_categories[count.index].metrics : {
      category = category
    }]

    content {
      category = metric.value.category
      enabled = true

      retention_policy {
        enabled = true
      }
    }
  }
}