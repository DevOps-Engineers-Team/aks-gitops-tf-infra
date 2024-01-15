module "acr" {
  source   = "../../../modules/acr"
  tags     = local.default_tags
  acr_name = local.acr_name

  azure_resource_group_name = local.azure_resource_group_name
  pe_subnet_id              = local.pe_subnet_id
  kubelet_identity          = data.terraform_remote_state.aks_cluster.outputs.kubelet_identity[0].object_id

  images_to_import = var.images_to_import
}
