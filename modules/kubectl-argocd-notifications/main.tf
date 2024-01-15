resource "kubectl_manifest" "sa_argocd_notifications_ctrl" {
    yaml_body = data.template_file.sa_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "role_argocd_notifications_ctrl" {
    depends_on = [kubectl_manifest.sa_argocd_notifications_ctrl]
    yaml_body = data.template_file.role_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "rb_argocd_notifications_ctrl" {
    depends_on =[kubectl_manifest.role_argocd_notifications_ctrl]
    yaml_body = data.template_file.rb_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "cm_argocd_notifications_ctrl" {
    depends_on =[kubectl_manifest.rb_argocd_notifications_ctrl]
    yaml_body = data.template_file.cm_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "secret_argocd_notifications_ctrl" {
    depends_on =[kubectl_manifest.cm_argocd_notifications_ctrl]
    yaml_body = data.template_file.secret_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "svc_argocd_notifications_ctrl" {
    depends_on =[kubectl_manifest.secret_argocd_notifications_ctrl]
    yaml_body = data.template_file.svc_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "deploy_argocd_notifications_ctrl" {
    depends_on =[kubectl_manifest.svc_argocd_notifications_ctrl]
    yaml_body = data.template_file.deploy_argocd_notifications_ctrl.rendered
    override_namespace = var.kubernetes_namespace
}

resource "kubectl_manifest" "argocd_template_data" {
    depends_on =[kubectl_manifest.deploy_argocd_notifications_ctrl]
    yaml_body = data.template_file.argocd_template_data.rendered
    override_namespace = var.kubernetes_namespace
}
