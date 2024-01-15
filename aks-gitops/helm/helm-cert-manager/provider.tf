provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id = var.tenant_id
  use_msi = true
  # client_id = var.client_id
  # client_secret = var.client_secret
  skip_provider_registration = "true"
  features {}
}

provider "kubernetes" {
  host = data.terraform_remote_state.aks_cluster.outputs.aks_cluster_host
  client_key = base64decode(data.terraform_remote_state.aks_cluster.outputs.aks_cluster_client_key)
  client_certificate = base64decode(data.terraform_remote_state.aks_cluster.outputs.aks_cluster_client_certificate)
  cluster_ca_certificate = base64decode(data.terraform_remote_state.aks_cluster.outputs.aks_cluster_cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host = data.terraform_remote_state.aks_cluster.outputs.aks_cluster_host
    client_key = base64decode(data.terraform_remote_state.aks_cluster.outputs.aks_cluster_client_key)
    client_certificate = base64decode(data.terraform_remote_state.aks_cluster.outputs.aks_cluster_client_certificate)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.aks_cluster.outputs.aks_cluster_cluster_ca_certificate)
  }
}
