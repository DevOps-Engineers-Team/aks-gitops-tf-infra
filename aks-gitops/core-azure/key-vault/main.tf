module "key_vault" {
    source = "../../../modules/key-vault"
    project = local.project
    stack = local.stack
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    kv_name = local.kv_name
    tenant_id = var.tenant_id
    
    principal_ids = local.principal_ids

    secrets_config = local.secrets_config

    diagnostic_name = local.diagnostic_name
    metrics_categories = var.metrics_categories
    log_categories = var.log_categories
    log_analytics_ws_id = data.terraform_remote_state.log_analytics.outputs.workspace_id
}
