locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  platform = "az"
  region_code = "e1"
  default_tags    = {
    CreatedBy     = "Terraform"
    Environment   = local.stack,
    BU            = local.project,
  }
  azure_resource_group_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
  aks_cluster_name =  "${local.platform}-${local.project}-${local.stack}-${local.region_code}-cluster-aks"
  dns_prefix = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-aks"
  node_resource_group_name =  "${local.platform}-${local.project}-${local.region_code}-${local.stack}-aks-rg"
  aks_user_assigned_identity_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-aks-mi"
  aks_user_assigned_identity_id = "/subscriptions/${var.subscription_id}/resourceGroups/cd-aks-gitops-e1-dev-rg/providers/Microsoft.ManagedIdentity/userAssignedIdentities/${local.aks_user_assigned_identity_name}"
  acd_identifier = "acd-${random_id.unique_id.hex}"
  cluster_identifier = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-ocean"
}

variable "identity_type" {
  default = "UserAssigned"
}

variable "network_plugin" {
  default = "azure"
}

variable "network_policy" {
  default = "azure"
}

variable "create_aks" {
  type = bool
  default = true
}

variable "create_controller" {
  type = bool
  default = true
}

variable "create_ocean" {
  type = bool
  default = true
}

variable "private_cluster_enabled" {
  type        = bool
  default     = true
}

variable "net_profile_outbound_type" {
  type        = string
  default     = "userDefinedRouting"
}

variable "availability_zones" {
  type =list(string)
  default = ["1", "2", "3"] # []
}

variable "zones" {
  type =list(string)
  default = ["1", "2", "3"]
}

variable "node_pools_headrooms" {
  type        = map(map(string))
  description = "Map of maps containing headroom configuration by node pool name"
  default = {
    all      = {
      cpu_per_unit = 4
      gpu_per_unit = 8
      memory_per_unit = 100
      num_of_units = 16
    },
    nodepool = {},
  }
}

variable "agents_min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
  default     = 1
}

variable "kubernetes_version_prefix" {
  default = "1.23"
}

variable "autoscaler_max_memory_gib" {
  type = number
  default = 100
}

variable "enable_role_based_access_control" {
  type        = bool
  default     = true
}

variable "rbac_aad_managed" {
  type        = bool
  default     = true
}

variable "private_dns_zone_id" {}

variable "vnet_subnet_id" {}

variable "subscription_id" {} 

variable "tenant_id" {}

# variable "client_id" {}

# variable "client_secret" {}
