variable "project" {}

variable "argocd_namespace" {}

variable "projectspace" {}

variable "cluster_address" {
    default = "https://kubernetes.default.svc"
}

variable "helm_charts_repo_ssh_url" {}

variable "sync_window_duration" {}

variable "cron_scheduling" {}
