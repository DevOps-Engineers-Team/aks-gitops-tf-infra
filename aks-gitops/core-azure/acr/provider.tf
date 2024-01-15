provider "azurerm" {
  subscription_id            = var.subscription_id
  tenant_id                  = var.tenant_id
  use_msi                    = true
  skip_provider_registration = "true"
  features {}
}
