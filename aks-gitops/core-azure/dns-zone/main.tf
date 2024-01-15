module "dns_zone" {
    source = "../../../modules/dns-zone"

    tags = local.default_tags

    azure_resource_group_name = data.azurerm_resource_group.rg.name
    azure_resource_group_location = data.azurerm_resource_group.rg.location

    domain_name = var.domain_name
}
