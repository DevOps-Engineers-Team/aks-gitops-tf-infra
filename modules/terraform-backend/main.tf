resource "azurerm_storage_account" "backend" {
  name                      = var.sa_name
  resource_group_name       = var.azure_resource_group_name
  location                  = var.azure_resource_group_location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  # enable_https_traffic_only = true
  # min_tls_version           = "TLS1_2"
  tags                      = var.tags

  network_rules {
    default_action = "Deny"
  }
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }  
}

resource "azurerm_storage_container" "backend" {
  depends_on = [time_sleep.wait]
  name                  = "tfbackend"
  storage_account_name  = azurerm_storage_account.backend.name
  container_access_type = "private"
}

resource "time_sleep" "wait" {
  depends_on = [ 
    azurerm_private_endpoint.backend,
    azurerm_storage_account.backend,
  ]
  create_duration = "60s"
}

resource "azurerm_private_endpoint" "backend" {
  name                = "${var.platform}-${var.project}-${var.stack}-${var.region_code}-${var.sa_name}-pe"
  resource_group_name       = var.azure_resource_group_name
  location                  = var.azure_resource_group_location
  subnet_id                 = var.pe_subnet_id
  
  private_service_connection {
    name                = "${var.platform}-${var.project}-${var.stack}-${var.region_code}-${var.sa_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.backend.id
    subresource_names              = ["blob"]
  }
  lifecycle {
    ignore_changes = [
      tags,
      private_dns_zone_group,
   ]
  }  
}
