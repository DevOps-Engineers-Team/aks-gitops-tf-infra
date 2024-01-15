resource "azurerm_public_ip" "app_gw_pip" {
  name                = "${var.app_gw_name}-pip"
  resource_group_name = var.azure_resource_group_name
  location            = var.azure_resource_group_location
  allocation_method   = var.public_ip_allocation_method
  sku = "Standard"
}

resource "azurerm_application_gateway" "app_gw" {
  name                = var.app_gw_name
  resource_group_name = var.azure_resource_group_name
  location            = var.azure_resource_group_location

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.sku_capacity
  }

  gateway_ip_configuration {
    name      = local.gateway_ip_config_name
    subnet_id = var.frontend_subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.frontend_port_number
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gw_pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = var.backend_cookie_based_affinity
    path                  = var.backend_path
    port                  = var.backend_port_number
    protocol              = var.backend_protocol
    request_timeout       = var.backend_request_timeout
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = var.backend_protocol
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = var.request_routing_rule_type
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority                   =  var.request_routing_rule_priority
  }

  waf_configuration {
    enabled = var.enable_waf_config
    firewall_mode = var.waf_firewall_mode
    rule_set_type = var.waf_rule_set_type
    rule_set_version = var.waf_rule_set_version
  }
}

resource "azurerm_monitor_diagnostic_setting" "app_gw_diagnostic" {
  depends_on = [data.azurerm_monitor_diagnostic_categories.app_gw_diag_categories]
  name               = var.diagnostic_name

  target_resource_id = azurerm_application_gateway.app_gw.id
  log_analytics_workspace_id = var.log_analytics_ws_id

  dynamic "log" {
    for_each = var.log_categories != null ? var.log_categories : toset(data.azurerm_monitor_diagnostic_categories.app_gw_diag_categories.logs)
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
    for_each = var.metrics_categories != null ? var.metrics_categories : toset(data.azurerm_monitor_diagnostic_categories.app_gw_diag_categories.metrics)
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

resource "azurerm_dns_a_record" "agw_a_record" {
  for_each = var.records_names
  name                = each.value #var.record_name
  zone_name           = var.zone_name
  resource_group_name = var.azure_resource_group_name
  ttl                 = var.ttl
  target_resource_id  = azurerm_public_ip.app_gw_pip.id
}
