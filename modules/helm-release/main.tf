resource "kubernetes_namespace" "helm_generic" {
  count = var.kubernetes_namespace != null ? 1 : 0
  metadata {
    name = var.kubernetes_namespace
  }
}

resource "helm_release" "release" {
  depends_on = [kubernetes_namespace.helm_generic]

  name       = "${var.helm_chart_name}-${var.stack}"
  repository = var.helm_repo_url
  chart      = var.helm_chart_name
  namespace  = var.kubernetes_namespace
  version    = var.helm_chart_version == "" ? null : var.helm_chart_version
  skip_crds = var.skip_crds

  values = var.helm_init_values

  dynamic "set" {
    for_each = var.helm_sets
    iterator = set
    content {
      name = set.value["name"]
      value = set.value["value"]
      type = set.value["type"]
    }
  }
}
