module "subnet_nsg" {
    source = "../../../modules/subnet-nsg"
    project = local.project
    stack = local.stack
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    vnet_name = data.terraform_remote_state.virtual_network.outputs.vnet_name
    az_subnet_name = var.ghshr_az_subnet_name
    az_subnet_address = var.ghshr_az_subnet_address
    az_inbound_ports_map = var.az_inbound_ports_map
}

module "app_gw_fe" {
    source = "../../../modules/subnet-nsg"
    project = local.project
    stack = local.stack
    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    vnet_name = data.terraform_remote_state.virtual_network.outputs.vnet_name
    az_subnet_name = var.app_gw_fe_az_subnet_name
    az_subnet_address = var.app_gw_fe_az_subnet_address
    az_inbound_ports_map = var.az_inbound_ports_map
}
