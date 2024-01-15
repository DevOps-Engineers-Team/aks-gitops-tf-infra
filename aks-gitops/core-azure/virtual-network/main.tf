module "virtual_network" {
    source = "../../../modules/virtual-network"
    project = local.project
    stack = local.stack
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    vnet_name = var.vnet_name
    vnet_address_space = var.vnet_address_space
}
