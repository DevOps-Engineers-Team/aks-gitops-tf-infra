output "app_gw_id" {
    value = azurerm_application_gateway.app_gw.id
}

output "app_gw_name" {
    value = var.app_gw_name
}

output "app_gw_log_categories" {
    value = data.azurerm_monitor_diagnostic_categories.app_gw_diag_categories.logs
}

output "app_gw_metrics_categories" {
    value = data.azurerm_monitor_diagnostic_categories.app_gw_diag_categories.metrics
}
