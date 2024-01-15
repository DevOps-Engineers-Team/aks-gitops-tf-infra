locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  platform      = "azure"
  region_code   = "e1"
  default_tags  = {
    CreatedBy    = "Terraform",
    MaintainedBy = "aks-gitops-Team",
    Environment  = local.stack,
    BU           = local.project,
  }
  azure_resource_group_name       = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
  aks_user_assigned_identity_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-aks-mi"
}

variable "helm_repo_url" {
  default = "https://appgwingress.blob.core.windows.net/ingress-azure-helm-package"
}

variable "kubernetes_namespace" {
  default = "agic"
}

variable "helm_chart_name" {
  default = "ingress-azure"
}

variable "helm_chart_version" {
  default = "1.5.2"
}

variable "subscription_id" {}

variable "tenant_id" {}

variable "helm_sets" {
  default = {
    ingress_class = {
      name  = "kubernetes.ingressClassResource.enabled"
      value = false
      type  = "auto"
    }
  }
}

variable "image_version" {
  default = "1.5.2"
}

variable "image_repository" {
  default = "cdaks-gitopsdeve1acr.azurecr.io/azure-application-gateway/kubernetes-ingress"
}
