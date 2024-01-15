module "helm_argocd" {
    source = "../../../modules/helm-release"
    stack = local.stack
    helm_repo_url    = var.helm_repo_url
    kubernetes_namespace = var.kubernetes_namespace
    helm_chart_name = var.helm_chart_name
    helm_chart_version = var.helm_chart_version
    helm_init_values = module.helm_config.helm_values
    helm_sets = var.helm_sets
}

module "argocd_ingress" {
    depends_on = [module.helm_argocd]
    source = "../../../modules/kubernetes-ingress-v1"
    ingress_annotations = local.ingress_annotations
    ingress_name = var.ingress_name
    kubernetes_namespace = var.kubernetes_namespace
    tls_sercret_name = var.tls_sercret_name
    host_name = var.argocd_server_host
    service_name = local.service_name
    port_number = var.port_number
}

module "argocd_admin_password" {
  depends_on = [module.helm_argocd, data.kubernetes_secret.argocd_server_secret]
  source = "../../../modules/kv-secret"
  secret_name         = var.secret_name
  secret_value        = data.kubernetes_secret.argocd_server_secret.data["password"]
  key_vault_id = data.terraform_remote_state.key_vault.outputs.key_vault_id
  created_by = local.created_by
}
