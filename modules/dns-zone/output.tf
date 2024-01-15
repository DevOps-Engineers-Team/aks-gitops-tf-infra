output "name_servers" {
    value = azurerm_dns_zone.dns_zone.name_servers
}

output "zone_id" {
    value = azurerm_dns_zone.dns_zone.id
}
