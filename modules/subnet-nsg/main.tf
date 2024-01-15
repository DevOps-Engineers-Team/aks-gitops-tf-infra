resource "azurerm_subnet" "az_subnet" {
  name                 = "${var.vnet_name}-${var.az_subnet_name}"
  resource_group_name  = var.azure_resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.az_subnet_address  
}

resource "azurerm_network_security_group" "az_subnet_nsg" {
  name                = "${azurerm_subnet.az_subnet.name}-nsg"
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "az_subnet_nsg_associate" {
  depends_on = [azurerm_network_security_rule.az_nsg_rule_inbound]  
  subnet_id                 = azurerm_subnet.az_subnet.id
  network_security_group_id = azurerm_network_security_group.az_subnet_nsg.id
}

resource "azurerm_network_security_rule" "az_nsg_rule_inbound" {
  for_each = var.az_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.azure_resource_group_name
  network_security_group_name = azurerm_network_security_group.az_subnet_nsg.name
}
