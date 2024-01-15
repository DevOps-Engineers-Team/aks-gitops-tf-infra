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

variable "argocd_apps_config" {
  type = map(map(string))
  default = {
    "demo-app" = {
        app_name = "app-deploy-svc"
        helm_charts_repo_path = "aks-gitops/argocd-apps-helm-charts/demo-app"
        helm_charts_repo_ssh_url = "ssh://git@github.com/DevOps-Engineers-Team/aks-gitops-tf-infra.git"
        helm_charts_repo_revision = "main"
    }
    "agic-ingress" = {
        app_name = "app-gw-ingress"
        helm_charts_repo_path = "aks-gitops/argocd-apps-helm-charts/app-gw-ingress"
        helm_charts_repo_ssh_url = "ssh://git@github.com/DevOps-Engineers-Team/aks-gitops-tf-infra.git"
        helm_charts_repo_revision = "main"
    }
  }
}

variable "notification_slack_channel_name" {
  default = "proj-aks-gitops-argocd-notifications"
}

variable "argocd_namespace" {
  default = "argocd"
}

variable "subscription_id" {} 

variable "tenant_id" {}

# variable "client_id" {}

# variable "client_secret" {}
