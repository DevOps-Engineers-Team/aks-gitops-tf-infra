terraform {
  required_version = ">= 1.0.0"

  required_providers {
    spotinst = {
      source  = "WitoldSlawko/spotinst"
      version = "1.77.10"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.55"
    }
  }
}

