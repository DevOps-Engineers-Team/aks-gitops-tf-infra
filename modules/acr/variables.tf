variable "tags" {
  type        = map(string)
  description = "Resource tags"
  default     = {}
}

variable "azure_resource_group_name" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "location" {
  description = "Location which ACR gets deployed to"
  default     = "westeurope"
  type        = string
}

variable "pe_subnet_id" {
  description = "Private endpoint subnet id"
  type        = string
}

variable "sku" {
  description = "Azure Container Registry service tiers"
  type        = string
  default     = "Premium"
}

variable "kubelet_identity" {
  description = "Object id of the identity object"
  type        = string
}

variable "images_to_import" {
  type = map(object({
    source = string
    image  = string
  }))
}