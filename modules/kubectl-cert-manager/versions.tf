terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.5.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.11.0"
    }
    kubectl = {
      source = "gavinbunney/kubectl"
      version = "~> 1.14.0"
    }
  }
  required_version = ">= 1.0.0"
}
