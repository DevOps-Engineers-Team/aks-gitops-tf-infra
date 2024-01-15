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

variable "vnet_name" {
  default = "vnet"
}

variable "vnet_address_space" {
  default = ["10.1.0.0/16"]
}
