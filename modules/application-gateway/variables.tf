locals {
  gateway_ip_config_name = "${var.app_gw_name}-gateway-ip-config"
  backend_address_pool_name      = "${var.app_gw_name}-backend-adress-pool"
  frontend_port_name             = "${var.app_gw_name}-frontend-port"
  frontend_ip_configuration_name = "${var.app_gw_name}-frontend-ip-config"
  http_setting_name              = "${var.app_gw_name}-http-setting"
  listener_name                  = "${var.app_gw_name}-listener"
  request_routing_rule_name      = "${var.app_gw_name}-request-routing-rule"
  redirect_configuration_name    = "${var.app_gw_name}-request-config"
}

variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "app_gw_name" {}

variable "diagnostic_name" {}

variable "log_analytics_ws_id" {}

variable "frontend_subnet_id" {}

variable "frontend_port_number" {
  type = number
}

variable "backend_port_number" {
  type = number
}

variable "backend_cookie_based_affinity" {
  default = "Enabled"
}

variable "metrics_categories" {
  type = set(string)
  default = null
}

variable "log_categories" {
  type = set(string)
  default = null
}

variable "backend_path" {
  default = "/app1/"
}

variable "backend_protocol" {
  default = "Http"
}

variable "backend_request_timeout" {
  type = number
  default = 60
}

variable "public_ip_allocation_method" {
  default = "Static" # "Dynamic"
}

variable "sku_name" {
  default = "WAF_v2" # "Standard_v2"
}

variable "sku_tier" {
  default = "WAF_v2" # "Standard_v2"
}

variable "sku_capacity" {
  type = number
  default = 2
}

variable "request_routing_rule_type" {
  default = "Basic"
}

variable "request_routing_rule_priority" {
  type = number
  default = 10
}

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

variable "enable_waf_config" {
  type = bool
  default = true
}

variable "waf_firewall_mode" {
  default = "Prevention"
}

variable "waf_rule_set_type" {
  default = "OWASP"
}

variable "waf_rule_set_version" {
  default = "3.2"
}

variable "ttl" {
  type = number
  default = 300
}

variable "records_names" {
  type = map(string)
  default = {}
}

variable "zone_name" {}

variable "tags" {
  type    = map(string)
  default = {}
}
