module "kubectl_argocd_project" {
    source = "../../../modules/kubectl-argocd-project"
    
    project = data.terraform_remote_state.helm_argocd.outputs.argocd_project
    argocd_namespace = var.argocd_namespace
    projectspace = data.terraform_remote_state.namespaces.outputs.namespaces["aks-gitops_ns"]
    helm_charts_repo_ssh_url = var.helm_charts_repo_ssh_url
    sync_window_duration = var.sync_window_duration
    cron_scheduling = var.cron_scheduling
}
