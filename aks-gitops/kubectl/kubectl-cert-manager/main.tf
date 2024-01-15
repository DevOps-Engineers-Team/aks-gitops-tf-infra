module "kubectl_cert_manager" {
    source = "../../../modules/kubectl-cert-manager"
    
    email_address = var.email_address
    cluster_issuer_name = var.cluster_issuer_name
}
