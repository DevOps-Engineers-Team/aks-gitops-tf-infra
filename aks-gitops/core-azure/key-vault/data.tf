data "azurerm_resource_group" "rg" {
  name     = local.azure_resource_group_name
}

data "aws_ssm_parameter" "lambda_gh_reg_token_internal_auth" {
  name     = "/devops/secrets/lambda-gh-reg-token/internal-auth"
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
    resource_group_name = local.azure_resource_group_name
  }
}

data "azurerm_user_assigned_identity" "aks_mi" {
  name                = local.aks_user_assigned_identity_name
  resource_group_name =  local.azure_resource_group_name
}

data "azurerm_user_assigned_identity" "mi" {
  name                = local.user_assigned_identity_name
  resource_group_name =  local.azure_resource_group_name
}

