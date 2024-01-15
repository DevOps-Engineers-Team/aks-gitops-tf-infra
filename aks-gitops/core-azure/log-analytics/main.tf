module "log_analytics" {
    source = "../../../modules/log-analytics"

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    log_workspace_name = local.log_workspace_name

    tags = local.default_tags
}
