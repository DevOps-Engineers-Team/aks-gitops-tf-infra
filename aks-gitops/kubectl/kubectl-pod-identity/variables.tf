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

variable "mic_deploy_image" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/oss/azure/aad-pod-identity/mic:v1.8.9"
}

variable "nmi_ds_image" {
  default =  "cdaks-gitopsdeve1acr.azurecr.io/oss/azure/aad-pod-identity/nmi:v1.8.9"
}

# variable "client_id" {}

# variable "client_secret" {}
