terraform {
  backend "azurerm" {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/poc/managed-identity/terraform.state"
    # use_msi = "true"
    resource_group_name = "sandbox-self-service-20220510-131750-rg"
  }
}
