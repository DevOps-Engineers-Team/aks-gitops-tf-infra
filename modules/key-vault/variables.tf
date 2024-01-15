locals {
  pe_subnet_id =  "/subscriptions/${var.subscription_id}/resourceGroups/CD-dev-sen-Networking-Rg/providers/Microsoft.Network/virtualNetworks/CD-dev-sen-VNet/subnets/PrivateEndpointSubnet"
}

variable "project" {}

variable "stack" {}

variable "azure_resource_group_name" {}

variable "azure_resource_group_location" {}

variable "kv_name" {}

variable "diagnostic_name" {}

variable "tenant_id" {}

variable "principal_ids" {
  type = map(map(string))
  default = {}
}

variable "pe_subnet_id" {}

variable "secrets_config" {
  type = map(string)
  default = {}
}

variable "metrics_categories" {
  type = set(string)
  default = null
}

variable "log_categories" {
  type = set(string)
  default = null
}

variable "log_analytics_ws_id" {}

variable "log_enabled" {
  type = bool
  default = true
}

variable "enable_retention_policy" {
  type = bool
  default = true
}

variable "retention_policy_days" {
  type = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "subscription_id" {}
