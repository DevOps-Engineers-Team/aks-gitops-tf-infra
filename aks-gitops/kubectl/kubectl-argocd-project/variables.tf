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

variable "argocd_namespace" {
  default = "argocd"
}

variable "helm_charts_repo_ssh_url" {
  default = "ssh://git@github.com/DevOps-Engineers-Team/aks-gitops-tf-infra.git"
}

variable "sync_window_duration" {
  default = "1h"
}

variable "cron_scheduling" {
  default = "3 * * * *"
}

variable "subscription_id" {} 

variable "tenant_id" {}

# variable "client_id" {}

# variable "client_secret" {}
