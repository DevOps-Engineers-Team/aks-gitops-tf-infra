data "azurerm_resource_group" "rg" {
  name     = local.azure_resource_group_name
}

data "terraform_remote_state" "application_gateway" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/dev/application-gateway/terraform.state"
    use_msi = true
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    resource_group_name = "az-aks-gitops-e1-dev-rg"
  }
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
    resource_group_name = "az-aks-gitops-e1-dev-rg"
  }
}

data "azurerm_user_assigned_identity" "aks_mi" {
  name                = local.aks_user_assigned_identity_name
  resource_group_name =  local.azure_resource_group_name
}

module "helm_config" {
  source = "./helm-config"

  subscription_id     = var.subscription_id
  resource_group_name = data.azurerm_resource_group.rg.name
  application_gateway_name = data.terraform_remote_state.application_gateway.outputs.app_gw_name
  identity_resource_id = data.azurerm_user_assigned_identity.aks_mi.id
  identity_client_id = data.azurerm_user_assigned_identity.aks_mi.client_id
  aks_api_server_address = data.terraform_remote_state.aks_cluster.outputs.aks_cluster_host
  image_version = var.image_version
  image_repository = var.image_repository
}
