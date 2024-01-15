resource "kubectl_manifest" "argocd_project" {
    yaml_body = data.template_file.argocd_project.rendered
}
