locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  default_tags    = {
    CreatedBy     = "Terraform",
    MaintainedBy  = "Witold-Slawko",
        Environment   = local.stack,
    BU            = local.project,
  }
  managed_identity_name         = "${local.stack}-msi-terraform"
}

variable "azure_resource_group_name" {
    default = "sandbox-self-service-20220510-131750-rg"
}

variable "subscription_id" {} 

variable "tenant_id" {}

variable "client_id" {}

variable "client_secret" {}

variable "principal_id" {
  default = "290864a4-b92b-496d-b121-cd793311e383"
}

variable "builtin_role_name" {
  default = "Owner" # "Contributor"
}

