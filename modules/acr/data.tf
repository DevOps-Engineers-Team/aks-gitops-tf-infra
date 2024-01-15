data "template_file" "import_images_script" {
  for_each = var.images_to_import
  template = file("${path.module}/assets/import_images.sh")
  vars     = {
    SOURCE   = each.value.source
    NAME     = each.value.image
    ACR_NAME = var.acr_name
  }
}