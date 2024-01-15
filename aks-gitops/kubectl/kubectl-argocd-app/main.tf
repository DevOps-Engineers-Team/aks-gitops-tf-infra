module "kubectl_argocd_app" {
    for_each = var.argocd_apps_config
    source = "../../../modules/kubectl-argocd-app"
    
    notification_slack_channel_name = var.notification_slack_channel_name
    app_name = each.value["app_name"]
    project = data.terraform_remote_state.helm_argocd.outputs.argocd_project
    argocd_namespace = var.argocd_namespace
    projectspace = data.terraform_remote_state.namespaces.outputs.namespaces["aks-gitops_ns"]
    helm_charts_repo_path = each.value["helm_charts_repo_path"]
    helm_charts_repo_ssh_url = each.value["helm_charts_repo_ssh_url"]
    helm_charts_repo_revision = each.value["helm_charts_repo_revision"]
}
