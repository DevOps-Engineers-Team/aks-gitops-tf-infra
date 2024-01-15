data "azurerm_role_definition" "builtin" {
  name = var.builtin_role_name
}

data "azurerm_role_definition" "storage" {
  name = "Storage Blob Data Owner"
}

data "azurerm_subscription" "primary" {}

data "azurerm_client_config" "current" {}