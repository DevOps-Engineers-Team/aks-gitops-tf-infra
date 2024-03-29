apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    api-approved.kubernetes.io: unapproved
    controller-gen.kubebuilder.io/version: v0.5.0
  name: azureidentitybindings.aadpodidentity.k8s.io
spec:
  group: aadpodidentity.k8s.io
  names:
    kind: AzureIdentityBinding
    listKind: AzureIdentityBindingList
    plural: azureidentitybindings
    singular: azureidentitybinding
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .spec.azureIdentity
      name: AzureIdentity
      type: string
    - jsonPath: .spec.selector
      name: Selector
      type: string
    - description: CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.
      jsonPath: .metadata.creationTimestamp
      name: Age
      type: date
    name: v1
    schema:
      openAPIV3Schema:
        description: AzureIdentityBinding brings together the spec of matching pods and the identity which they can use.
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
            description: AzureIdentityBindingSpec matches the pod with the Identity. Used to indicate the potential matches to look for between the pod/deployment and the identities present.
            properties:
              azureIdentity:
                type: string
              metadata:
                type: object
              selector:
                type: string
              weight:
                description: Weight is used to figure out which of the matching identities would be selected.
                type: integer
            type: object
          status:
            description: AzureIdentityBindingStatus contains the status of an AzureIdentityBinding.
            properties:
              availableReplicas:
                format: int32
                type: integer
              metadata:
                type: object
            type: object
        type: object
    served: true
    storage: true
    subresources: {}
status:
  acceptedNames:
    kind: ""
    plural: ""
  conditions: []
  storedVersions: []