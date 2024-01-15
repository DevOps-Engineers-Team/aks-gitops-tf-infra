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
    resource_group_name = data.azurerm_resource_group.rg.name
  }
}

data "terraform_remote_state" "kubectl_cert_manager" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name       = "tfbackend"
    key                  = "aks-gitops/dev/kubectl-cert-manager/terraform.state"
    use_msi              = true
    subscription_id      = var.subscription_id
    tenant_id            = var.tenant_id
    resource_group_name = data.azurerm_resource_group.rg.name
  }
}

data "kubernetes_secret" "argocd_server_secret" {
  depends_on = [module.helm_argocd]
  metadata {
    name = var.secret_name # "argocd-initial-admin-secret"
    namespace = var.kubernetes_namespace
  }
}

module "helm_config" {
  source = "./helm-config"

  argocd_server_host = var.argocd_server_host
  argocd_github_client_id = data.azurerm_key_vault_secret.argocd_github_client_id.value
  argocd_github_client_secret = data.azurerm_key_vault_secret.argocd_github_client_secret.value
  argocd_github_org_name = var.argocd_github_org_name
  argocd_ingress_enabled = var.argocd_ingress_enabled
  argocd_ingress_tls_acme_enabled = var.argocd_ingress_tls_acme_enabled
  argocd_ingress_ssl_passthrough_enabled = var.argocd_ingress_ssl_passthrough_enabled
  argocd_ingress_class = var.argocd_ingress_class
  argocd_ingress_tls_secret_name = var.argocd_ingress_tls_secret_name
  github_team = var.github_team
  argocd_project = local.argocd_project
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
    resource_group_name = local.azure_resource_group_name
  }
}

data "azurerm_key_vault_secret" "argocd_github_client_id" {
  name         = "argocd-github-client-id"
  key_vault_id = data.terraform_remote_state.key_vault.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "argocd_github_client_secret" {
  name         = "argocd-github-client-secret"
  key_vault_id = data.terraform_remote_state.key_vault.outputs.key_vault_id
}

