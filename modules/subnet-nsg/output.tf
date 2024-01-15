output "subnet_name" {
    value = azurerm_subnet.az_subnet.name
}

output "nsg_id" {
    value = azurerm_network_security_group.az_subnet_nsg.id
}

output "subnet_id" {
    value = azurerm_subnet.az_subnet.id
}
