data "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group_name
}

data "terraform_remote_state" "virtual_network" {
  backend = "azurerm"
  config = {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/poc/virtual-network/terraform.state"
    # use_msi = "true"
    resource_group_name = "sandbox-self-service-20220510-131750-rg"
  }
}