terraform {
  backend "azurerm" {
    storage_account_name = "aksgitopsdevtf"
    container_name = "tfbackend"
    key = "aks-gitops/dev/aks-cluster/terraform.state"
    use_msi = true
    resource_group_name = "az-aks-gitops-e1-dev-rg"
  }
}
