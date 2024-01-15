variable "notification_slack_channel_name" {}

variable "app_name" {}

variable "argocd_namespace" {}

variable "projectspace" {}

variable "cluster_address" {
    default = "https://kubernetes.default.svc"
}

variable "project" {}

variable "helm_charts_repo_path" {}

variable "helm_charts_repo_ssh_url" {}

variable "helm_charts_repo_revision" {}
