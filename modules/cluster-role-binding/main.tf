resource "kubernetes_cluster_role_binding" "this" {

  metadata {
    name = var.name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.cluster_role
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = var.service_account
    namespace = var.namespace
  }
}
