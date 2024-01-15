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
  application_gateway_name         = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-agw"
  diagnostic_name = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-diag"
  frontend_subnet_id = "/subscriptions/${var.subscription_id}/resourceGroups/CD-dev-sen-Networking-Rg/providers/Microsoft.Network/virtualNetworks/CD-dev-sen-VNet/subnets/ApplicationGateway"
}

variable "frontend_subnet_id" {}

variable "frontend_port_number" {
  type = number
  default = 80
}

variable "backend_port_number" {
  type = number
  default = 80
}

variable "records_names" {
  type = map(string)
  default = {
    argocd_subdomain = "argocd"
    web_subdomain = "web"
  }
}

variable "zone_name" {
  default = "witold-demo.net"
}

variable "metrics_categories" {
  type = set(string)
  default = []
}

variable "log_categories" {
  type = set(string)
  default = ["ApplicationGatewayAccessLog", "ApplicationGatewayFirewallLog"]
}

variable "subscription_id" {} 

variable "tenant_id" {}

# variable "client_id" {}

# variable "client_secret" {}

