module "terraform_backend" {
    source = "../../../modules/terraform-backend"
    project = local.project
    stack = local.stack
    tags = local.default_tags
    sa_name = local.sa_name
    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location
}
