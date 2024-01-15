locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  platform = "az"
  region_code = "e1"
  default_tags    = {
    CreatedBy     = "Terraform"
    Environment   = local.stack,
    BU            = local.project,
  }
  azure_resource_group_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
}

variable "subscription_id" {} 

variable "tenant_id" {}

variable "kubernetes_namespace" {
  default = "argocd"
}

variable "argocd_notifications_image_repository" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/argoprojlabs/argocd-notifications:v1.0.2"
}


# variable "client_id" {}

# variable "client_secret" {}
