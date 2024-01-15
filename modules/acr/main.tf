resource "azurerm_container_registry" "acr" {
  name                          = var.acr_name
  resource_group_name           = var.azure_resource_group_name
  location                      = var.location
  sku                           = var.sku
  admin_enabled                 = false
  public_network_access_enabled = false
  tags                          = var.tags
}

resource "azurerm_private_endpoint" "acr_pe" {
  name                = "${azurerm_container_registry.acr.name}-pe"
  location            = var.location
  resource_group_name = var.azure_resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "${azurerm_container_registry.acr.name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
  }
  lifecycle {
    ignore_changes = [
      tags,
      private_dns_zone_group,
    ]
  }
}

resource "azurerm_role_assignment" "acr_pull" {
  principal_id                     = var.kubelet_identity
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

resource "null_resource" "import_images" {
  for_each   = data.template_file.import_images_script
  depends_on = [azurerm_container_registry.acr, azurerm_private_endpoint.acr_pe]

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = "echo ${data.template_file.import_images_script[each.key].rendered}"
  }
}