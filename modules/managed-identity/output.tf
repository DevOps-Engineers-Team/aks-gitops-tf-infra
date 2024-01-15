output "mi_id" {
    value = azurerm_user_assigned_identity.managed_identity.id
}

output "mi_principal_id" {
    value = azurerm_user_assigned_identity.managed_identity.principal_id
}

output "mi_client_id" {
    value = azurerm_user_assigned_identity.managed_identity.client_id
}
