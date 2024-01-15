locals {
  stack   = basename(dirname(path.cwd))
  project = basename(dirname(dirname(path.cwd)))
  platform      = "azure"
  region_code   = "e1"
  default_tags  = {
    CreatedBy    = "Terraform",
    MaintainedBy = "aks-gitops-Team",
    Environment  = local.stack,
    BU           = local.project,
  }

  acr_name                  = "${local.platform}${local.project}${local.stack}${local.region_code}acr"
  azure_resource_group_name = "${local.platform}-${local.project}-${local.region_code}-${local.stack}-rg"
  pe_subnet_id              = "/subscriptions/${var.subscription_id}/resourceGroups/CD-dev-sen-Networking-Rg/providers/Microsoft.Network/virtualNetworks/CD-dev-sen-VNet/subnets/PrivateEndpointSubnet"
  location                  = "westeurope"
}

variable "subscription_id" {}

variable "tenant_id" {}

variable "images_to_import" {
  default = {
    "openjdk" = {
      source = "docker.io/library/openjdk:17"
      image  = "openjdk:17"
    }
    "kubernetes-dashboard" = {
      source = "docker.io/kubernetesui/dashboard:v2.5.0"
      image  = "kubernetesui/dashboard:v2.5.0"
    }
    "kubernetes-dashboard-metrics" = {
      source = "docker.io/kubernetesui/metrics-scraper:v1.0.7"
      image  = "kubernetesui/metrics-scraper:v1.0.7"
    }
    "azure-keyvault-controller" = {
      source = "docker.io/spvest/azure-keyvault-controller:1.3.2"
      image = "spvest/azure-keyvault-controller:1.3.2"
    }
    "azure-keyvault-webhook" = {
      source = "docker.io/spvest/azure-keyvault-webhook:1.3.1"
      image = "spvest/azure-keyvault-webhook:1.3.1"
    }
    "azure-keyvault-env" = {
      source = "docker.io/spvest/azure-keyvault-env:1.3.1"
      image = "spvest/azure-keyvault-env:1.3.1"
    }
    "agic" = {
      source = "mcr.microsoft.com/azure-application-gateway/kubernetes-ingress:1.5.2"
      image = "azure-application-gateway/kubernetes-ingress:1.5.2"
    }
    "nmi" = {
      source = "mcr.microsoft.com/oss/azure/aad-pod-identity/nmi:v1.8.9"
      image = "oss/azure/aad-pod-identity/nmi:v1.8.9"
    }
    "mic" = {
      source = "mcr.microsoft.com/oss/azure/aad-pod-identity/mic:v1.8.9"
      image = "oss/azure/aad-pod-identity/mic:v1.8.9"
    }
    "kubernetes-cluster-controller" = {
      source = "gcr.io/spotinst-artifacts/kubernetes-cluster-controller:1.0.82"
      image = "spotinst-artifacts/kubernetes-cluster-controller:1.0.82"
    }
    "ocean-aks-connector" = {
      source = "docker.io/spotinst/ocean-aks-connector:1.0.8"
      image = "spotinst/ocean-aks-connector:1.0.8"
    }
    "keda" = {
      source = "ghcr.io/kedacore/keda:2.8.0"
      image = "kedacore/keda:2.8.0"
    }
    "keda-metrics" = {
      source = "ghcr.io/kedacore/keda-metrics-apiserver:2.8.0"
      image = "kedacore/keda-metrics-apiserver:2.8.0"
    }
    "dapr" = {
      source = "docker.io/daprio/dapr:1.8.4"
      image = "daprio/dapr:1.8.4"
    }
    "dapr-dashboard" = {
      source = "docker.io/daprio/dashboard:0.10.0"
      image = "daprio/dashboard:0.10.0"
    }
    "cert-manager-controller" = {
      source = "quay.io/jetstack/cert-manager-controller:v1.8.2"
      image = "jetstack/cert-manager-controller:v1.8.2"
    }
    "cert-manager-cainjector" = {
      source = "quay.io/jetstack/cert-manager-cainjector:v1.8.2"
      image = "jetstack/cert-manager-cainjector:v1.8.2"
    }
    "cert-manager-webhook" = {
      source = "quay.io/jetstack/cert-manager-webhook:v1.8.2"
      image = "jetstack/cert-manager-webhook:v1.8.2"
    }
    "cert-manager-ctl" = {
      source = "quay.io/jetstack/cert-manager-ctl:v1.8.2"
      image = "jetstack/cert-manager-ctl:v1.8.2"
    }
    "argocd-notifications" = {
      source ="docker.io/argoprojlabs/argocd-notifications:v1.0.2"
      image = "argoprojlabs/argocd-notifications:v1.0.2"
    }
  }
}
