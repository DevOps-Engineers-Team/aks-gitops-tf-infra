locals {
  aks_cluster_name = (
    var.aks_cluster_name == null
    ? format("%s-aks", var.prefix)
    : var.aks_cluster_name
  )

  ocean_cluster_id = (
    var.create_ocean
    ? spotinst_ocean_aks.cluster[0].id
    : null
  )

  ocean_controller_cluster_id = (
    var.cluster_identifier != null
    ? var.cluster_identifier
    : local.aks_cluster_name
  )

  ocean_acd_identifier = (
    var.acd_identifier != null
    ? var.acd_identifier
    : local.aks_cluster_name
  )

  public_ssh_key = (replace(
    var.public_ssh_key == ""
    ? module.ssh.public_ssh_key
    : var.public_ssh_key, "\n", "")
  )

  username = var.admin_username

  agents_labels = merge(
    lookup(var.node_pools_labels, "all", {}),
    lookup(var.node_pools_labels, var.agents_pool_name, {}),
  )

  agents_tags = merge(
    lookup(var.node_pools_tags, "all", {}),
    lookup(var.node_pools_tags, var.agents_pool_name, {}),
  )

  node_pool_names = (
    [for np in toset(var.node_pools) : np.name]
  )

  node_pools = zipmap(
    local.node_pool_names,
    tolist(toset(var.node_pools))
  )

  node_resource_group_name = (
    var.create_aks
    ? module.aks[0].node_resource_group
    : format(
      "MC_%s_%s_%s", # MC_<AKS resource group>_<AKS cluster name>_<AKS region>
      var.resource_group_name,
      local.aks_cluster_name,
      data.azurerm_kubernetes_cluster.cluster[0].location,
    )
  )

  kubelet_identity_object_id = (
    var.create_aks
    ? module.aks[0].kubelet_identity[0].object_id
    : data.azurerm_kubernetes_cluster.cluster[0].kubelet_identity[0].object_id
  )

  kubelet_identity_name = (
    var.user_assigned_identity_name != null
    ? var.user_assigned_identity_name
    : format(
      "%s-agentpool", # <AKS cluster name>-agentpool
      local.aks_cluster_name,
    )
  )
}
