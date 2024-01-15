variable "domain_name" {}

variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "tags" {
  type    = map(string)
  default = {}
}
