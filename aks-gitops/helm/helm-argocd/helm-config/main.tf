data "template_file" "init" {
  template = "${file("${path.module}/templates/values.yaml.tpl")}"
  vars = {
    argocd_server_host          = var.argocd_server_host
    argocd_github_client_id     = var.argocd_github_client_id
    argocd_github_client_secret = var.argocd_github_client_secret
    argocd_github_org_name      = var.argocd_github_org_name
    argocd_ingress_enabled                 = var.argocd_ingress_enabled
    argocd_ingress_tls_acme_enabled        = var.argocd_ingress_tls_acme_enabled
    argocd_ingress_ssl_passthrough_enabled = var.argocd_ingress_ssl_passthrough_enabled
    argocd_ingress_class                   = var.argocd_ingress_class
    argocd_ingress_tls_secret_name         = var.argocd_ingress_tls_secret_name
    github_team         = var.github_team
    argocd_project         = var.argocd_project
  }
}
