data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "main" {
  name                    = var.cluster_name == null ? "${var.prefix}-aks" : var.cluster_name
  kubernetes_version      = var.kubernetes_version
  location                = data.azurerm_resource_group.main.location
  resource_group_name     = data.azurerm_resource_group.main.name
  node_resource_group = var.node_resource_group_name
  dns_prefix              = var.prefix
  sku_tier                = var.sku_tier
  private_cluster_enabled = var.private_cluster_enabled
   private_dns_zone_id = var.private_dns_zone_id

  linux_profile {
    admin_username = var.admin_username

    ssh_key {
      key_data = var.public_ssh_key
    }
  }

  dynamic "default_node_pool" {
    for_each = var.enable_auto_scaling == true ? [] : ["default_node_pool_manually_scaled"]
    content {
      orchestrator_version  = var.orchestrator_version
      name                  = var.agents_pool_name
      node_count            = var.agents_count
      vm_size               = var.agents_size
      os_disk_size_gb       = var.os_disk_size_gb
      vnet_subnet_id        = var.vnet_subnet_id
      enable_auto_scaling   = var.enable_auto_scaling
      max_count             = null
      min_count             = null
      enable_node_public_ip = var.enable_node_public_ip
      availability_zones    = var.agents_availability_zones
      node_labels           = var.agents_labels
      type                  = var.agents_type
      tags                  = merge(var.tags, var.agents_tags)
      max_pods              = var.agents_max_pods
    }
  }

  dynamic "default_node_pool" {
    for_each = var.enable_auto_scaling == true ? ["default_node_pool_auto_scaled"] : []
    content {
      orchestrator_version  = var.orchestrator_version
      name                  = var.agents_pool_name
      vm_size               = var.agents_size
      os_disk_size_gb       = var.os_disk_size_gb
      vnet_subnet_id        = var.vnet_subnet_id
      enable_auto_scaling   = var.enable_auto_scaling
      max_count             = var.agents_max_count
      min_count             = var.agents_min_count
      enable_node_public_ip = var.enable_node_public_ip
      availability_zones    = var.agents_availability_zones
      node_labels           = var.agents_labels
      type                  = var.agents_type
      tags                  = merge(var.tags, var.agents_tags)
      max_pods              = var.agents_max_pods
    }
  }

  dynamic "kubelet_identity" {
    for_each = (var.mi_client_id != null && var.mi_object_id != null) ? ["kubelet_identity"] : []
    content {
      client_id = var.mi_client_id
      object_id = var.mi_object_id
      user_assigned_identity_id = var.user_assigned_identity_id
    }
  }

  dynamic "service_principal" {
    for_each = var.client_id != "" && var.client_secret != "" ? ["service_principal"] : []
    content {
      client_id     = var.client_id
      client_secret = var.client_secret
    }
  }

  dynamic "identity" {
    for_each = var.client_id == "" || var.client_secret == "" ? ["identity"] : []
    content {
      type                      = var.identity_type
      user_assigned_identity_id = var.user_assigned_identity_id
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = var.app_gateway_id != null ? ["app_gateway"] : []
    content {
      gateway_id = var.app_gateway_id
    }
  }

  http_application_routing_enabled = var.enable_http_application_routing

  azure_policy_enabled = var.enable_azure_policy

  dynamic "oms_agent" {
    for_each = var.log_analytics_workspace_id != null ? ["log_analytics_workspace"] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id # azurerm_log_analytics_workspace.main[0].id
    }
  }

  role_based_access_control {
    enabled = var.enable_role_based_access_control

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed                = true
        admin_group_object_ids = var.rbac_aad_admin_group_object_ids
        azure_rbac_enabled = true
      }
    }

    dynamic "azure_active_directory" {
      for_each = var.enable_role_based_access_control && !var.rbac_aad_managed ? ["rbac"] : []
      content {
        managed           = false
        client_app_id     = var.rbac_aad_client_app_id
        server_app_id     = var.rbac_aad_server_app_id
        server_app_secret = var.rbac_aad_server_app_secret
      }
    }
  }

  network_profile {
    network_plugin     = var.network_plugin
    network_policy     = var.network_policy
    dns_service_ip     = var.net_profile_dns_service_ip
    docker_bridge_cidr = var.net_profile_docker_bridge_cidr
    outbound_type      = var.net_profile_outbound_type
    pod_cidr           = var.net_profile_pod_cidr
    service_cidr       = var.net_profile_service_cidr
  }

  tags = var.tags
}
