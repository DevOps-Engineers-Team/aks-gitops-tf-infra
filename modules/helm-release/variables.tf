variable "stack" {}

variable "helm_repo_url" {
  description = "Helm repository"
  type        = string
}

variable "kubernetes_namespace" {
  description = "Namespace to release into"
  type        = string
  default     = null
}

variable "helm_chart_name" {
  description = "helm chart name to use"
  type        = string
}

variable "helm_init_values" {
  type = list(string)
  default = []
}

variable "skip_crds" {
  type = bool
  default = false
}

variable "helm_chart_version" {
  description = "helm chart version to use"
  type        = string
}

variable "helm_sets" {
  type = map(object({
    name = string
    value = any
    type = string
  }))
  default = {}
}
