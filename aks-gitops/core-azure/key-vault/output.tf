output "key_vault_id" {
    value = module.key_vault.key_vault_id
}

output "key_vault_name" {
    value = local.kv_name
}

output "kv_log_categories" {
    value = module.key_vault.kv_log_categories
}

output "kv_metrics_categories" {
    value = module.key_vault.kv_metrics_categories
}
