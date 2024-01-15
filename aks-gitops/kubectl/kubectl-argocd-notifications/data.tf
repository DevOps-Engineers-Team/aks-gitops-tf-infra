data "azurerm_resource_group" "rg" {
  name     = local.azure_resource_group_name
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
    # client_id = var.client_id
    # client_secret = var.client_secret
    resource_group_name = data.azurerm_resource_group.rg.name
  }
}

data "terraform_remote_state" "key_vault" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/dev/key-vault/terraform.state"
    use_msi = true
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    # client_id = var.client_id
    # client_secret = var.client_secret
    resource_group_name = data.azurerm_resource_group.rg.name
  }
}

data "azurerm_key_vault_secret" "argocd_slack_token" {
  name         = "argocd-slack-notification-app-token"
  key_vault_id = data.terraform_remote_state.key_vault.outputs.key_vault_id
}
