# Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.stack}-${var.vnet_name}"
  address_space       = var.vnet_address_space
  resource_group_name       = var.azure_resource_group_name
  location                  = var.azure_resource_group_location
  tags = local.default_tags
}

