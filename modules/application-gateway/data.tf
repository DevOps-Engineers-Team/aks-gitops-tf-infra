data "azurerm_monitor_diagnostic_categories" "app_gw_diag_categories" {
  resource_id = azurerm_application_gateway.app_gw.id
}
