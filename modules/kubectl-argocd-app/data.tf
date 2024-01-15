data "template_file" "argocd_app" {
    template = "${file("${path.module}/manifests/argocd-app.yaml")}"
    vars = {
        notification_slack_channel_name = var.notification_slack_channel_name
        app_name = var.app_name
        argocd_namespace = var.argocd_namespace
        projectspace = var.projectspace
        cluster_address = var.cluster_address
        project = var.project
        helm_charts_repo_path = var.helm_charts_repo_path
        helm_charts_repo_ssh_url = var.helm_charts_repo_ssh_url
        helm_charts_repo_revision = var.helm_charts_repo_revision
    }
}

