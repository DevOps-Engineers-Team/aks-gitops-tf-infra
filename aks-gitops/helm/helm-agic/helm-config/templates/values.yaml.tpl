# This file contains the essential configs for the ingress controller helm chart

image:
  repository: ${imageRepository}
  tag: ${imageVersion}
  pullPolicy: IfNotPresent

# Verbosity level of the App Gateway Ingress Controller
verbosityLevel: 5

################################################################################
# Specify which application gateway the ingress controller will manage
#
appgw:
    subscriptionId: ${subscriptionId}
    resourceGroup: ${resourceGroupName}
    name: ${applicationGatewayName}

    # Setting appgw.shared to "true" will create an AzureIngressProhibitedTarget CRD.
    # This prohibits AGIC from applying config for any host/path.
    # Use "kubectl get AzureIngressProhibitedTargets" to view and change this.
    shared: false

################################################################################
# Specify the authentication with Azure Resource Manager
#
# Two authentication methods are available:
# - Option 1: AAD-Pod-Identity (https://github.com/Azure/aad-pod-identity)
armAuth:
    type: aadPodIdentity
    identityResourceID: ${identityResourceId}
    identityClientID:  ${identityClientId}

## Alternatively you can use Service Principal credentials
# armAuth:
#    type: servicePrincipal
#    secretJSON: <<Generate this value with: "az ad sp create-for-rbac --role Contributor --sdk-auth | base64 -w0" >>

################################################################################
# Specify if the cluster is Kubernetes RBAC enabled or not
rbac:
    enabled: false # true/false

# Specify aks cluster related information. THIS IS BEING DEPRECATED.
aksClusterConfiguration:
    apiServerAddress: ${aksApiServerAddress}

################################################################################
# Specify which kubernetes namespace the ingress controller will watch
# Default value is "default"
# Leaving this variable out or setting it to blank or empty string would
# result in Ingress Controller observing all acessible namespaces.
#
kubernetes:
    watchNamespace: ""
