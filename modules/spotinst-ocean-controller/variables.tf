locals {
  prefix                 = "spotinst-kubernetes-cluster-controller"
  namespace              = var.namespace
  secret_name            = coalesce(var.secret_name, local.prefix)
  service_account_name   = coalesce(var.service_account_name, local.prefix)
  config_map_name        = coalesce(var.config_map_name, format("%s-config", local.prefix))
  ca_bundle_secret_name  = coalesce(var.ca_bundle_secret_name, format("%s-ca-bundle", local.prefix))
  aks_connector_job_name = coalesce(var.aks_connector_job_name, format("%s-aks-connector", local.prefix))
}

variable "namespace" {
  type        = string
  default = "spotinst"
}

variable "spotinst_token" {
  type        = string
  description = "Specifies the Spot Personal Access token"
}

variable "spotinst_account" {
  type        = string
  description = "Specifies the Spot account ID"
}

variable "cluster_identifier" {
  type        = string
  description = "Specifies the cluster identifier"
}

variable "create_controller" {
  type        = bool
  description = "Controls whether the Ocean Controller should be deployed (it affects all resources)"
  default     = true
}

variable "controller_image" {
  type        = string
  description = "Specifies the Docker image name for the Ocean Controller that should be deployed"
  default     = "gcr.io/spotinst-artifacts/kubernetes-cluster-controller"
#  default     = "cdaks-gitopsdeve1acr.azurecr.io/spotinst-artifacts/kubernetes-cluster-controller" // uncomment in case of new deployment / redeployment of the aks cluster
}

variable "controller_version" {
  type        = string
  description = "Specifies the Docker version for the Ocean Controller that should be deployed"
  default     = "1.0.82" # "1.0.81"
}

variable "image_pull_policy" {
  type        = string
  description = "Specifies the image pull policy (one of: Always, Never, IfNotPresent)"
  default     = "Always"
}

variable "base_url" {
  type        = string
  description = "Specifies the base URL to be used by the HTTP client"
  default     = ""
}

variable "proxy_url" {
  type        = string
  description = "Specifies the proxy server URL to communicate through"
  default     = ""
}

variable "enable_csr_approval" {
  type        = bool
  description = "Controls whether the CSR approval feature should be enabled"
  default     = false
}

variable "disable_auto_update" {
  type        = bool
  description = "Controls whether the auto-update feature should be disabled"
  default     = false
}

variable "image_pull_secrets" {
  type        = list(string)
  description = "Specifies a list of references to secrets in the same namespace to use for pulling the image"
  default     = []
}

variable "resources_limits" {
  type        = map(any)
  description = "Specifies the definition of the maximum amount of compute resources allowed"
  default     = null
  //  default = {
  //    cpu    = "0.5"
  //    memory = "512Mi"
  //  }
}

variable "resources_requests" {
  type        = map(any)
  description = "Specifies the definition of the minimum amount of compute resources required"
  default     = null
  //  default = {
  //    cpu    = "0.5"
  //    memory = "512Mi"
  //  }
}

variable "tolerations" {
  type        = list(any)
  description = "Specifies a list of additional `toleration` objects, see: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod#toleration"
  default = [
    {
      key                = "node.kubernetes.io/not-ready"
      effect             = "NoExecute"
      operator           = "Exists"
      toleration_seconds = 150
    },
    {
      key                = "node.kubernetes.io/unreachable"
      effect             = "NoExecute"
      operator           = "Exists"
      toleration_seconds = 150
    },
  ]
}

variable "node_selector" {
  type        = map(string)
  description = "Specifies the node selector which must match a node's labels for the Ocean Controller resources to be scheduled on that node"
  default     = null
}

variable "aks_connector_enabled" {
  type        = bool
  description = "Controls whether the Ocean AKS Connector should be deployed (requires a valid `acd_identifier`)"
  default     = true
}

variable "aks_connector_image" {
  type        = string
  description = "Specifies the Docker image name for the Ocean AKS Connector that should be deployed"
  default     = "spotinst/ocean-aks-connector"
#  default     = "cdaks-gitopsdeve1acr.azurecr.io/spotinst/ocean-aks-connector" // uncomment in case of new deployment / redeployment of the aks cluster
}

variable "aks_connector_version" {
  type        = string
  description = "Specifies the Docker version for the Ocean AKS Connector that should be deployed"
  default     = "1.0.8" # "1.0.11"
}

variable "acd_identifier" {
  type        = string
  description = "Specifies a unique identifier used by the Ocean AKS Connector when importing an AKS cluster"
  default     = null
}

variable "secret_name" {
  type        = string
  description = "Overrides the default secret name"
  default     = null
}

variable "service_account_name" {
  type        = string
  description = "Overrides the default service account name"
  default     = null
}

variable "config_map_name" {
  type        = string
  description = "Overrides the default configmap name"
  default     = null
}

variable "ca_bundle_secret_name" {
  type        = string
  description = "Overrides the default secret name for custom CA bundle"
  default     = null
}

variable "aks_connector_job_name" {
  type        = string
  description = "Overrides the default job name for the Ocean AKS Connector"
  default     = null
}
