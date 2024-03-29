apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    api-approved.kubernetes.io: unapproved
    controller-gen.kubebuilder.io/version: v0.5.0
  name: azurepodidentityexceptions.aadpodidentity.k8s.io
spec:
  group: aadpodidentity.k8s.io
  names:
    kind: AzurePodIdentityException
    listKind: AzurePodIdentityExceptionList
    plural: azurepodidentityexceptions
    singular: azurepodidentityexception
  scope: Namespaced
  versions:
  - name: v1
    schema:
      openAPIV3Schema:
        description: AzurePodIdentityException contains the pod selectors for all pods that don't require NMI to process and request token on their behalf.
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: AzurePodIdentityExceptionSpec matches pods with the selector defined. If request originates from a pod that matches the selector, nmi will proxy the request and send response back without any validation.
            properties:
              metadata:
                type: object
              podLabels:
                additionalProperties:
                  type: string
                type: object
            type: object
          status:
            description: AzurePodIdentityExceptionStatus contains the status of an AzurePodIdentityException.
            properties:
              metadata:
                type: object
              status:
                type: string
            type: object
        type: object
    served: true
    storage: true
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []