data "template_file" "sa_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/01-sa-argocd-notifications-controller.yaml")
}

data "template_file" "role_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/02-role-argocd-notifications-controller.yaml")
}

data "template_file" "rb_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/03-rb-argocd-notifications-controller.yaml")
}

data "template_file" "cm_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/04-cm-argocd-notifications-controller.yaml")
}

data "template_file" "secret_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/05-secret-argocd-notifications-controller.yaml")
    vars = {
        argocd_slack_token = var.argocd_slack_token
    }
}

data "template_file" "svc_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/06-svc-argocd-notifications-controller.yaml")
}

data "template_file" "deploy_argocd_notifications_ctrl" {
    template = file("${path.module}/manifests/07-deploy-argocd-notifications-controller.yaml")
}

data "template_file" "argocd_template_data" {
    template = file("${path.module}/manifests/08-template-data.yaml")
    vars = {
        argocd_slack_token = var.argocd_slack_token
    }
}
