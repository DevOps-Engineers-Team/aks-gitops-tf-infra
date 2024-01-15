module "kubectl_pod_identity" {
    source = "../../../modules/kubectl-pod-identity"
    mic_deploy_image = var.mic_deploy_image
    nmi_ds_image = var.nmi_ds_image
    
    # namespace = var.namespace
}
