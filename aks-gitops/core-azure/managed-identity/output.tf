output "mi_name" {
    value = local.managed_identity_name
}

output "mi_id" {
    value = module.managed_identity.mi_id
}

output "mi_principal_id" {
    value = module.managed_identity.mi_principal_id
}

output "mi_client_id" {
    value = module.managed_identity.mi_client_id
}


output "aks_mi_name" {
    value = "${local.managed_identity_name}-aks"
}

output "aks_mi_id" {
    value = module.managed_identity_aks.mi_id
}

output "aks_mi_principal_id" {
    value = module.managed_identity_aks.mi_principal_id
}

output "aks_mi_client_id" {
    value = module.managed_identity_aks.mi_client_id
}
