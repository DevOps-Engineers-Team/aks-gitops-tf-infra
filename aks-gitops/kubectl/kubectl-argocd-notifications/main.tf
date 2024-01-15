module "kubectl-argocd-notifications" {
    source = "../../../modules/kubectl-argocd-notifications"

    argocd_notifications_image_repository = var.argocd_notifications_image_repository
    kubernetes_namespace = var.kubernetes_namespace
    argocd_slack_token = data.azurerm_key_vault_secret.argocd_slack_token.value
}
