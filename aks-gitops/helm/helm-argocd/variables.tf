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
  argocd_project = "${local.project}-${local.stack}-argocd-project"
  service_name = "${var.helm_chart_name}-${local.stack}-argocd-server"
  created_by = "${basename(dirname(dirname(path.cwd)))}/${basename(dirname(path.cwd))}/${basename(path.cwd)}"

  ingress_annotations = {
    "appgw.ingress.kubernetes.io/ssl-redirect" = "true"
    "kubernetes.io/ingress.class" = "azure/application-gateway"
    "nginx.ingress.kubernetes.io/proxy-buffer-size" = "32k"
    "nginx.ingress.kubernetes.io/affinity" = "cookie"
    "nginx.ingress.kubernetes.io/rewrite-target" = "/"
    "cert-manager.io/acme-challenge-type" = "http01"
    "cert-manager.io/cluster-issuer" = data.terraform_remote_state.kubectl_cert_manager.outputs.cluster_issuer_name
  }
}

# "acme.cert-manager.io/http01-edit-in-place" = "true"

variable "helm_repo_url" {
  default = "https://argoproj.github.io/argo-helm"
}

variable "kubernetes_namespace" {
  default = "argocd"
}

variable "helm_chart_name" {
  default = "argo-cd"
}

variable "helm_chart_version" {
  default = "3.32.1"
}

variable "subscription_id" {}

variable "tenant_id" {}

variable "helm_sets" {
  default = {
    image_tag = {
      name = "server.service.type"
      value = "ClusterIP"
      type = "string"
    }
  }
}

variable "argocd_ingress_class" {
  default     = "nginx"
}

variable "argocd_ingress_enabled" {
  type        = bool
  default     = true
}

variable "argocd_ingress_tls_acme_enabled" {
  default     = "true"
}

variable "argocd_ingress_ssl_passthrough_enabled" {
  default     = "true"
}

variable "argocd_ingress_tls_secret_name" {
  default     = "argocd-cert"
}

variable "argocd_github_org_name" {
  default = "DevOps-Engineers-Team"
}

variable "argocd_server_host" {
  default = "argocd.witold-demo.net"
}

variable "app_gw_ssl_redirect" {
  default = "true"
}

variable "github_team" {
  default = "doet-admins"
}

variable "ingress_name" {
  default = "argocd-ingress"
}

variable "secret_name" {
  default = "argocd-initial-admin-secret"
}

variable "tls_sercret_name" {
  default = "tls-secret-argocd"
}

variable "port_number" {
    type = number
    default = 443
}
