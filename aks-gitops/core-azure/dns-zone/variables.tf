locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  platform      = "azure"
  region_code   = "e1"
  default_tags = {
    CreatedBy    = "Terraform",
    MaintainedBy = "aks-gitops-Team",
    Environment  = local.stack,
    BU           = local.project,
  }

  azure_resource_group_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
}

variable "subscription_id" {}

variable "tenant_id" {}

variable "domain_name" {
  default = "witold-demo.net"
}
