data "template_file" "init" {
  template = file("${path.module}/templates/values.yaml.tpl")
  vars = {
    cm_controller_image_repository = var.cm_controller_image_repository
    cm_ca_injector_image_repository = var.cm_ca_injector_image_repository
    cm_webhook_image_repository = var.cm_webhook_image_repository
    cm_ctl_image_repository = var.cm_ctl_image_repository
    cm_images_version = var.cm_images_version
  }
}


