apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  annotations:
    api-approved.kubernetes.io: unapproved
    controller-gen.kubebuilder.io/version: v0.5.0
  name: azureidentities.aadpodidentity.k8s.io
spec:
  group: aadpodidentity.k8s.io
  names:
    kind: AzureIdentity
    listKind: AzureIdentityList
    plural: azureidentities
    singular: azureidentity
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .spec.type
      name: Type
      type: string
    - jsonPath: .spec.clientID
      name: ClientID
      type: string
    - description: CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.
      jsonPath: .metadata.creationTimestamp
      name: Age
      type: date
    name: v1
    schema:
      openAPIV3Schema:
        description: AzureIdentity is the specification of the identity data structure.
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
            description: AzureIdentitySpec describes the credential specifications of an identity on Azure.
            properties:
              adEndpoint:
                type: string
              adResourceID:
                description: For service principal. Option param for specifying the  AD details.
                type: string
              auxiliaryTenantIDs:
                description: Service principal auxiliary tenant ids
                items:
                  type: string
                nullable: true
                type: array
              clientID:
                description: Both User Assigned MSI and SP can use this field.
                type: string
              clientPassword:
                description: Used for service principal
                properties:
                  name:
                    description: Name is unique within a namespace to reference a secret resource.
                    type: string
                  namespace:
                    description: Namespace defines the space within which the secret name must be unique.
                    type: string
                type: object
              metadata:
                type: object
              replicas:
                format: int32
                nullable: true
                type: integer
              resourceID:
                description: User assigned MSI resource id.
                type: string
              tenantID:
                description: Service principal primary tenant id.
                type: string
              type:
                description: UserAssignedMSI or Service Principal
                type: integer
            type: object
          status:
            description: AzureIdentityStatus contains the replica status of the resource.
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