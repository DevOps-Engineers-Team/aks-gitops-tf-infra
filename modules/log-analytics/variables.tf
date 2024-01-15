variable "azure_resource_group_name" {}
variable "azure_resource_group_location" {}

variable "log_workspace_name" {}

variable "log_workspace_sku" {
  default = "PerGB2018"
}

variable "log_retention_in_days" {
  type = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}
