module "aks_cluster" {
    source = "../../../modules/aks-cluster"
    tags = local.default_tags

    spotinst_token   = data.azurerm_key_vault_secret.spotinst_token.value
    spotinst_account = data.azurerm_key_vault_secret.spotinst_account.value

    resource_group_name = data.azurerm_resource_group.rg.name
    resource_group_id = data.azurerm_resource_group.rg.id

    node_resource_group_name = local.node_resource_group_name

    create_aks = var.create_aks
    create_controller = var.create_controller
    create_ocean = var.create_ocean

    aks_cluster_name = local.aks_cluster_name
    cluster_identifier = local.cluster_identifier
    acd_identifier = local.acd_identifier
    prefix = local.dns_prefix

    identity_type = var.identity_type

    mi_client_id = data.azurerm_user_assigned_identity.aks_mi.client_id
    mi_object_id = data.azurerm_user_assigned_identity.aks_mi.principal_id

    network_plugin = var.network_plugin
    network_policy = var.network_policy

    agents_availability_zones = var.availability_zones
    zones =  var.availability_zones # var.zones

    private_cluster_enabled = var.private_cluster_enabled
    private_dns_zone_id = var.private_dns_zone_id

    user_assigned_identity_name = local.aks_user_assigned_identity_name
    user_assigned_identity_id = local.aks_user_assigned_identity_id
    vnet_subnet_id = var.vnet_subnet_id
    public_ssh_key = data.template_file.ssh_public_key.rendered

    app_gateway_id = data.terraform_remote_state.application_gateway.outputs.app_gw_id
    log_analytics_workspace_id = data.terraform_remote_state.log_analytics.outputs.workspace_id
    net_profile_outbound_type = var.net_profile_outbound_type

    kubernetes_version = data.azurerm_kubernetes_service_versions.kube_version.latest_version
    orchestrator_version = data.azurerm_kubernetes_service_versions.kube_version.latest_version

    node_pools_headrooms = var.node_pools_headrooms
    agents_min_count = var.agents_min_count

    autoscaler_max_memory_gib = var.autoscaler_max_memory_gib
}
