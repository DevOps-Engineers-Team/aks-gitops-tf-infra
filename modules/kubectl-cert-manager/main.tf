resource "kubectl_manifest" "crd_cluster_issuer" {
    yaml_body = data.template_file.crd_cluster_issuer.rendered
}
