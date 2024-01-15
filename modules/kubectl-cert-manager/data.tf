data "template_file" "crd_cluster_issuer" {
    template = "${file("${path.module}/manifests/cluster-issuer.yaml")}"
    vars = {
        email_address = var.email_address
        cluster_issuer_name = var.cluster_issuer_name
    }
}

