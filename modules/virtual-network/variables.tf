locals {
  default_tags    = {
    CreatedBy     = "terraform"Environment   = var.stack,
    BU            = var.project,
  }
}

variable "project" {}
variable "stack" {}

variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "vnet_name" {}
variable "vnet_address_space" {}

variable "tags" {
  type    = map(string)
  default = {}
}
