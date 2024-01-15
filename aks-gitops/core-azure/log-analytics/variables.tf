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
  log_workspace_name = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-log"
}

variable "subscription_id" {} 

variable "tenant_id" {}

# variable "client_id" {}

# variable "client_secret" {}
