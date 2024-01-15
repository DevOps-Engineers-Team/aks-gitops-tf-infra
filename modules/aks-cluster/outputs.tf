// region azure/aks

output "client_key" {
  value = var.create_aks ? module.aks[0].client_key : null
}

output "client_certificate" {
  value = var.create_aks ? module.aks[0].client_certificate : null
}

output "cluster_ca_certificate" {
  value = var.create_aks ? module.aks[0].cluster_ca_certificate : null
}

output "host" {
  value = var.create_aks ? module.aks[0].host : null
}

output "username" {
  value = var.create_aks ? module.aks[0].username : null
}

output "password" {
  value = var.create_aks ? module.aks[0].password : null
}

output "node_resource_group" {
  value = var.create_aks ? module.aks[0].node_resource_group : null
}

output "location" {
  value = var.create_aks ? module.aks[0].location : null
}

output "aks_id" {
  value = var.create_aks ? module.aks[0].aks_id : null
}

output "kube_config_raw" {
  value = var.create_aks ? module.aks[0].kube_config_raw : null
}

output "system_assigned_identity" {
  value = var.create_aks ? module.aks[0].system_assigned_identity : null
}

output "kubelet_identity" {
  value = var.create_aks ? module.aks[0].kubelet_identity : null
}

output "admin_client_key" {
  value = var.create_aks ? module.aks[0].admin_client_key : null
}

output "admin_client_certificate" {
  value = var.create_aks ? module.aks[0].admin_client_certificate : null
}

output "admin_cluster_ca_certificate" {
  value = var.create_aks ? module.aks[0].admin_cluster_ca_certificate : null
}

output "admin_host" {
  value = var.create_aks ? module.aks[0].admin_host : null
}

output "admin_username" {
  value = var.create_aks ? module.aks[0].admin_username : null
}

output "admin_password" {
  value = var.create_aks ? module.aks[0].admin_password : null
}

// endregion

// region spotinst/ocean-aks

output "ocean_cluster_id" {
  description = "The ID of the Ocean cluster"
  value       = var.create_ocean ? local.ocean_cluster_id : null
}

output "ocean_cluster_name" {
  description = "The name of the Ocean cluster"
  value       = var.create_ocean ? local.aks_cluster_name : null
}

output "ocean_controller_cluster_id" {
  description = "The ID of the Ocean controller"
  value       = var.create_ocean ? local.ocean_controller_cluster_id : null
}

output "ocean_acd_identifier" {
  description = "The identifier used by the Ocean AKS Connector to import the AKS cluster"
  value       = var.create_ocean ? local.ocean_acd_identifier : null
}

// endregion
