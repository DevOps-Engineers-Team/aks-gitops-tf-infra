locals {
  default_tags    = {
    CreatedBy     = "terraform"Environment   = var.stack,
    BU            = var.project,
  }
}

variable "project" {}
variable "stack" {}

variable "principal_id" {}
variable "rg_name" {}

variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "managed_identity_name" {}
variable "builtin_role_name" {}

variable "tags" {
  type    = map(string)
  default = {}
}
