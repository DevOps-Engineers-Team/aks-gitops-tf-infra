data "azurerm_monitor_diagnostic_categories" "kv_diag_categories" {
  resource_id = azurerm_key_vault.kv.id
}
