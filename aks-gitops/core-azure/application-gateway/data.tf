data "azurerm_resource_group" "rg" {
  name     = local.azure_resource_group_name
}

data "terraform_remote_state" "log_analytics" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/dev/log-analytics/terraform.state"
    use_msi = true
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    # client_id = var.client_id
    # client_secret = var.client_secret
    resource_group_name = "az-aks-gitops-e1-dev-rg"
  }
}
