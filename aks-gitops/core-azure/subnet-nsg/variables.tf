locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  default_tags    = {
    CreatedBy     = "Terraform",
    MaintainedBy  = "Witold-Slawko",
        Environment   = local.stack,
    BU            = local.project,
  }
}

variable "azure_resource_group_name" {
    default = "sandbox-self-service-20220510-131750-rg"
}

variable "subscription_id" {} 

variable "tenant_id" {}

variable "client_id" {}

variable "client_secret" {}

variable "ghshr_az_subnet_name" {
  default = "subnet"
}

variable "ghshr_az_subnet_address" {
  default = ["10.1.0.0/22"]
}

variable "app_gw_fe_az_subnet_name" {
  default = "app-gw-fe-subnet"
}

variable "app_gw_fe_az_subnet_address" {
  default = ["10.1.4.0/22"]
}

variable "az_inbound_ports_map" {
  default = {
    "100" = "80",
    "110" = "443",
    "120" = "8080",
    "130" = "22",
    "140" = "65200-65535"
    "150" = "30000-32768"
  } 
}
