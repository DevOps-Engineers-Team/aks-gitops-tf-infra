data "azurerm_resource_group" "rg" {
  name = local.azure_resource_group_name
}

data "terraform_remote_state" "aks_cluster" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name       = "tfbackend"
    key                  = "aks-gitops/dev/aks-cluster/terraform.state"
    use_msi              = true
    subscription_id      = var.subscription_id
    tenant_id            = var.tenant_id
    resource_group_name  = data.azurerm_resource_group.rg.name
  }
}
