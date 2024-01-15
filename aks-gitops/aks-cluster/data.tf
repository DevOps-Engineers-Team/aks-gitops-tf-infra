data "azurerm_resource_group" "rg" {
  name     = local.azure_resource_group_name
}

data "azurerm_kubernetes_service_versions" "kube_version" {
  location = data.azurerm_resource_group.rg.location
  version_prefix = var.kubernetes_version_prefix
  include_preview = false
}

data "azurerm_user_assigned_identity" "aks_mi" {
  name                = local.aks_user_assigned_identity_name
  resource_group_name =  local.azure_resource_group_name
}

data "template_file" "ssh_public_key" {
  template = "${file("${path.module}/assets/terraform-azure.pub")}"
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
    resource_group_name = "az-aks-gitops-e1-dev-rg"
  }
}

data "azurerm_key_vault_secret" "spotinst_account" {
  name         = "spotinst-account"
  key_vault_id = data.terraform_remote_state.key_vault.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "spotinst_token" {
  name         = "spotinst-token"
  key_vault_id = data.terraform_remote_state.key_vault.outputs.key_vault_id
}

resource "random_id" "unique_id" {
  byte_length = 4
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


data "terraform_remote_state" "application_gateway" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/dev/application-gateway/terraform.state"
    use_msi = true
    subscription_id = var.subscription_id
    tenant_id = var.tenant_id
    # client_id = var.client_id
    # client_secret = var.client_secret
    resource_group_name = "az-aks-gitops-e1-dev-rg"
  }
}
