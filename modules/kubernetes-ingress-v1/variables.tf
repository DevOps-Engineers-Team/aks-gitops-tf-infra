variable "ingress_name" {}

variable "kubernetes_namespace" {}

# variable "cert_manager_cluster_issuer" {}

variable "tls_sercret_name" {}

variable "ingress_annotations" {
    type = map(string)
    default = {}
}

variable "port_number" {
    type = number
}

variable "host_name" {}

variable "service_name" {}

variable "url_path" {
    default = "/"
}
