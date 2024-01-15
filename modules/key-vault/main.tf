resource "azurerm_key_vault" "kv" {
  name                = var.kv_name
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
  purge_protection_enabled = true

  tenant_id = var.tenant_id
  sku_name  = "standard"

  enable_rbac_authorization = true

  network_acls {
    bypass = "None"
    default_action = "Deny"
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "kv_rw" {
  for_each = var.principal_ids
  principal_id                     = each.value["principal_id"]
  role_definition_name             = "Key Vault Secrets Officer"
  scope                            = azurerm_key_vault.kv.id
}

resource "azurerm_private_endpoint" "kv_pe" {
  name                = "${var.kv_name}-pe"
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${var.kv_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
  }
  lifecycle {
    ignore_changes = [
      tags,
      private_dns_zone_group,
    ]
  }
}

resource "azurerm_key_vault_secret" "single_secret" {
  depends_on = [azurerm_role_assignment.kv_rw]
  for_each = var.secrets_config
  name         = each.key
  value        = each.value
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_monitor_diagnostic_setting" "kv_diagnostic" {
  depends_on = [data.azurerm_monitor_diagnostic_categories.kv_diag_categories]
  name               = var.diagnostic_name

  target_resource_id = azurerm_key_vault.kv.id
  log_analytics_workspace_id = var.log_analytics_ws_id

  dynamic "log" {
    for_each = var.log_categories != null ? var.log_categories : toset(data.azurerm_monitor_diagnostic_categories.kv_diag_categories.logs)

    iterator = diagnostic_log
    content {
      category = diagnostic_log.value # var.log_category
      enabled  = var.log_enabled

      retention_policy {
        enabled = var.enable_retention_policy
        days = var.retention_policy_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.metrics_categories != null ? var.metrics_categories : toset(data.azurerm_monitor_diagnostic_categories.kv_diag_categories.metrics)
    iterator = diagnostic_metric
    content {
      category = diagnostic_metric.value # var.metric_category

      retention_policy {
        enabled = var.enable_retention_policy
        days = var.retention_policy_days
      }
    }
  }
}
