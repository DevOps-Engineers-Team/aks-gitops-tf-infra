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
  sa_name         = join("", [local.project,local.stack,"tf"])
  azure_resource_group_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
}

variable "subscription_id" {} 

variable "tenant_id" {}

# variable "client_id" {}

# variable "client_secret" {}
