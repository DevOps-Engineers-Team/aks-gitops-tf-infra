resource "kubernetes_ingress_v1" "ingress" {
  metadata {
    name = var.ingress_name
    namespace =  var.kubernetes_namespace
    annotations = var.ingress_annotations
  }
  spec {
    rule {
      host = var.host_name
      http {
        path {
          path = var.url_path
          backend {
            service {
              name = var.service_name
              port {
                number = var.port_number
              }
            }
          }
        }
      }
    }
    dynamic "tls" {
      for_each = var.tls_sercret_name != null ? ["cert_manager_tls"] : []
      content {
        hosts = [var.host_name]
        secret_name = var.tls_sercret_name
      }
    }
  }
}
