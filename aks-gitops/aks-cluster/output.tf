output "aks_cluster_host" {
    value = module.aks_cluster.host
}

output "aks_cluster_client_key" {
    value = module.aks_cluster.client_key
}

output "aks_cluster_client_certificate" {
    value = module.aks_cluster.client_certificate
}

output "aks_cluster_cluster_ca_certificate" {
    value = module.aks_cluster.cluster_ca_certificate
}

output "kubelet_identity" {
    value = module.aks_cluster.kubelet_identity
}
