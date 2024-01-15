module "managed_identity" {
    source = "../../../modules/managed-identity"
    project = local.project
    stack = local.stack
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    managed_identity_name = local.managed_identity_name
    builtin_role_name = var.builtin_role_name
    principal_id = var.principal_id
    rg_name = var.azure_resource_group_name
}


module "managed_identity_aks" {
    source = "../../../modules/managed-identity"
    project = local.project
    stack = local.stack
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    managed_identity_name = "${local.managed_identity_name}-aks"
    builtin_role_name = var.builtin_role_name
    principal_id = var.principal_id
    rg_name = var.azure_resource_group_name
}
