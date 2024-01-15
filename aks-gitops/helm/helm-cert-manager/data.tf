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

module "helm_config" {
  source = "./helm-config"
  cm_ca_injector_image_repository = var.cm_ca_injector_image_repository
  cm_controller_image_repository = var.cm_controller_image_repository
  cm_ctl_image_repository = var.cm_ctl_image_repository
  cm_webhook_image_repository = var.cm_webhook_image_repository
  cm_images_version = var.cm_images_version
}
