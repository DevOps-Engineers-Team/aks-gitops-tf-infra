data "template_file" "argocd_project" {
    template = "${file("${path.module}/manifests/argocd-project.yaml")}"
    vars = {
        project = var.project
        argocd_namespace = var.argocd_namespace
        projectspace = var.projectspace
        cluster_address = var.cluster_address
        helm_charts_repo_ssh_url = var.helm_charts_repo_ssh_url
        sync_window_duration = var.sync_window_duration
        cron_scheduling = var.cron_scheduling
    }
}

