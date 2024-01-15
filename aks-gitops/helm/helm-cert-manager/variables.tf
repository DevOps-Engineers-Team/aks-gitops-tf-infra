locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  platform      = "azure"
  region_code   = "e1"
  default_tags = {
    CreatedBy    = "Terraform",
    MaintainedBy = "aks-gitops-Team",
    Environment  = local.stack,
    BU           = local.project,
  }
  azure_resource_group_name       = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
}

variable "helm_repo_url" {
  default = "https://charts.jetstack.io"
}

variable "helm_chart_name" {
  default = "cert-manager"
}

variable "helm_chart_version" {
  default = "1.9.1" # "1.8.2"
}

variable "kubernetes_namespace" {
  default = "cert-manager"
}

variable "cm_controller_image_repository" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/jetstack/cert-manager-controller"
}

variable "cm_ca_injector_image_repository" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/jetstack/cert-manager-cainjector"
}

variable "cm_webhook_image_repository" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/jetstack/cert-manager-webhook"
}

variable "cm_ctl_image_repository" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/jetstack/cert-manager-ctl"
}

variable "cm_images_version" {
  default = "1.8.2"
}

variable "subscription_id" {}

variable "tenant_id" {}
