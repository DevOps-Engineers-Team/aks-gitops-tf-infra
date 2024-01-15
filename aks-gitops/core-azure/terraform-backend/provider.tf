provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  use_msi = true
  # client_id = var.client_id
  # client_secret = var.client_secret
  skip_provider_registration = "true"
  features {}
}
