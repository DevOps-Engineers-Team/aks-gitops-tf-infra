module "application_gateway" {
    source = "../../../modules/application-gateway"
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    app_gw_name = local.application_gateway_name
    frontend_subnet_id = var.frontend_subnet_id
    frontend_port_number = var.frontend_port_number
    backend_port_number = var.backend_port_number

    diagnostic_name = local.diagnostic_name
    log_analytics_ws_id = data.terraform_remote_state.log_analytics.outputs.workspace_id

    metrics_categories = var.metrics_categories
    log_categories = var.log_categories
    
    records_names = var.records_names
    zone_name = var.zone_name
}
