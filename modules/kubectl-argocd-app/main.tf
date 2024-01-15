resource "kubectl_manifest" "argocd_app" {
    yaml_body = data.template_file.argocd_app.rendered
}
