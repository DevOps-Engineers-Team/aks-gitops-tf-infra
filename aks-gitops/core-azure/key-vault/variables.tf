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
  secrets_config = {
    "lambda-gh-reg-token-internal-auth" = data.aws_ssm_parameter.lambda_gh_reg_token_internal_auth.value
  }
  kv_name = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-kv"
  diagnostic_name = "${local.platform}-${local.project}-${local.stack}-${local.region_code}-diag"
  aks_user_assigned_identity_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-aks-mi"
  user_assigned_identity_name = "${local.platform}-${local.project}-${local.stack}-mi"

  principal_ids = {
    "managed_identity" = { 
      "principal_id" =  data.azurerm_user_assigned_identity.mi.principal_id
    },
     "aks_managed_identity" = { 
      "principal_id" =  data.azurerm_user_assigned_identity.aks_mi.principal_id
    }
  }
}

variable "subscription_id" {} 

variable "tenant_id" {}

variable "metrics_categories" {
  type = set(string)
  default = []
}

variable "log_categories" {
  type = set(string)
  default = ["AuditEvent"]
}

# variable "client_id" {}

# variable "client_secret" {}
