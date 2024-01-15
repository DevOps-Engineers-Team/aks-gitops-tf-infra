resource "azurerm_user_assigned_identity" "managed_identity" {
 resource_group_name       = var.azure_resource_group_name
  location                  = var.azure_resource_group_location

  name = var.managed_identity_name
}

resource "azurerm_role_assignment" "mi_role_assign" {
  scope              = "${data.azurerm_subscription.primary.id}/resourceGroups/${var.rg_name}"
  role_definition_id = data.azurerm_role_definition.builtin.id
  principal_id       = azurerm_user_assigned_identity.managed_identity.principal_id
}

resource "azurerm_role_assignment" "storage" {
  scope              = "${data.azurerm_subscription.primary.id}/resourceGroups/${var.rg_name}"
  role_definition_id = data.azurerm_role_definition.storage.id
  principal_id       = azurerm_user_assigned_identity.managed_identity.principal_id
}
