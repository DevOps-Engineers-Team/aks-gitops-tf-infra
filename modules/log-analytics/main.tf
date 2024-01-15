resource "azurerm_log_analytics_workspace" "log_workspace" {
  name                = var.log_workspace_name
  resource_group_name   = var.azure_resource_group_name
  location              = var.azure_resource_group_location
  sku                 = var.log_workspace_sku
  retention_in_days   = var.log_retention_in_days

  tags = var.tags
}

resource "azurerm_log_analytics_solution" "log_solution" {
  solution_name         = "ContainerInsights"
  resource_group_name   = var.azure_resource_group_name
  location              = var.azure_resource_group_location
  workspace_resource_id = azurerm_log_analytics_workspace.log_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.log_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = var.tags
}
