locals {
  default_tags    = {
    CreatedBy     = "terraform"Environment   = var.stack,
    BU            = var.project,
  }
  # az_inbound_ports_map = {
  #   "100" : "80",
  #   "110" : "443",
  #   "120" : "8080",
  #   "130" : "22"
  # } 
}

variable "project" {}
variable "stack" {}

variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "vnet_name" {}
variable "az_subnet_name" {}
variable "az_subnet_address" {}

variable "az_inbound_ports_map" {}

variable "tags" {
  type    = map(string)
  default = {}
}
