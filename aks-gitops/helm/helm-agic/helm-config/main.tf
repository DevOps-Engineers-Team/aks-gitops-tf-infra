data "template_file" "init" {
  template = file("${path.module}/templates/values.yaml.tpl")
  vars = {
    subscriptionId = var.subscription_id
    resourceGroupName = var.resource_group_name
    applicationGatewayName = var.application_gateway_name
    identityResourceId = var.identity_resource_id
    identityClientId = var.identity_client_id
    aksApiServerAddress = var.aks_api_server_address
    imageVersion = var.image_version
    imageRepository = var.image_repository
  }
}


