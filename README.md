# aks-gitops-tf-infra

    .
    ├── aks-gitops
    │   ├── aks-cluster
    │   │   └── assets
    │   ├── argocd-apps-helm-charts
    │   │   ├── app-gw-ingress
    │   │   │   └── templates
    │   │   └── demo-app
    │   │       └── templates
    │   ├── core-azure
    │   │   ├── acr
    │   │   ├── application-gateway
    │   │   ├── dns-zone
    │   │   ├── key-vault
    │   │   ├── log-analytics
    │   │   ├── managed-identity
    │   │   ├── subnet-nsg
    │   │   ├── terraform-backend
    │   │   └── virtual-network
    │   ├── helm
    │   │   ├── helm-agic
    │   │   │   └── helm-config
    │   │   │       └── templates
    │   │   ├── helm-argocd
    │   │   │   └── helm-config
    │   │   │       └── templates
    │   │   └── helm-cert-manager
    │   │       └── helm-config
    │   │           └── templates
    │   └── kubectl
    │       ├── kubectl-argocd-app
    │       ├── kubectl-argocd-notifications
    │       ├── kubectl-argocd-project
    │       ├── kubectl-cert-manager
    │       └── kubectl-pod-identity
    └── modules
        ├── acr
        │   └── assets
        ├── aks-cluster
        │   └── modules
        │       ├── aks
        │       └── ssh
        ├── application-gateway
        ├── cluster-role-binding
        ├── dns-zone
        ├── helm-release
        ├── key-vault
        ├── kubectl-argocd-app
        │   └── manifests
        ├── kubectl-argocd-notifications
        │   └── manifests
        ├── kubectl-argocd-project
        │   └── manifests
        ├── kubectl-cert-manager
        │   └── manifests
        ├── kubectl-pod-identity
        │   └── manifests
        ├── kubernetes-ingress-v1
        ├── log-analytics
        ├── managed-identity
        ├── spotinst-ocean-controller
        ├── subnet-nsg
        ├── terraform-backend
        └── virtual-network
