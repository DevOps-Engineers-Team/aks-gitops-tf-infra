module "helm_agic" {
    source = "../../../modules/helm-release"
    stack = local.stack
    helm_repo_url    = var.helm_repo_url
    kubernetes_namespace = var.kubernetes_namespace
    helm_chart_name = var.helm_chart_name
    helm_chart_version = var.helm_chart_version
    helm_init_values = module.helm_config.helm_values
    helm_sets = var.helm_sets
}
