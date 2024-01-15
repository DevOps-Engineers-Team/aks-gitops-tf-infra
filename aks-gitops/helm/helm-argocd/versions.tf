terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 3.5.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.4.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.7.0"
    }
  }
  required_version = ">= 1.0.0"
}
