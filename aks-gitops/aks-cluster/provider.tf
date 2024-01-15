provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  use_msi = true
  # client_id = var.client_id
  # client_secret = var.client_secret
  skip_provider_registration = "true"
  features {}
}

provider "spotinst" {
  account = data.azurerm_key_vault_secret.spotinst_account.value
  token   = data.azurerm_key_vault_secret.spotinst_token.value
}

provider "kubernetes" {
  host = module.aks_cluster.host
  client_key = base64decode(module.aks_cluster.client_key)
  client_certificate = base64decode(module.aks_cluster.client_certificate)
  cluster_ca_certificate = base64decode(module.aks_cluster.cluster_ca_certificate)
}
