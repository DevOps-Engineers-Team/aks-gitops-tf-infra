output "key_vault_id" {
    value = azurerm_key_vault.kv.id
}

output "kv_log_categories" {
    value = data.azurerm_monitor_diagnostic_categories.kv_diag_categories.logs
}

output "kv_metrics_categories" {
    value = data.azurerm_monitor_diagnostic_categories.kv_diag_categories.metrics
}
