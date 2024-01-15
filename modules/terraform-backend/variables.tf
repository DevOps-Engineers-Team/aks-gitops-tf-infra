locals {
  pe_subnet_id =  "/subscriptions/${var.subscription_id}/resourceGroups/CD-dev-sen-Networking-Rg/providers/Microsoft.Network/virtualNetworks/CD-dev-sen-VNet/subnets/PrivateEndpointSubnet"
}

variable "project" {}

variable "stack" {}

variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "sa_name" {}

variable "platform" {
  default = "azure"
}

variable "region_code" {
  default = "e1"
}

variable "pe_subnet_id" {}

variable "subscription_id" {}

variable "tags" {
  type    = map(string)
  default = {}
}
