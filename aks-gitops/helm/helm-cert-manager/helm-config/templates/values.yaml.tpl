installCRDs: true

image:
  repository: ${cm_controller_image_repository}
  tag: ${cm_images_version}
  pullPolicy: IfNotPresent

webhook:
  image:
    repository: ${cm_webhook_image_repository}
    tag: ${cm_images_version}
    pullPolicy: IfNotPresent

cainjector:
  image:
    repository: ${cm_ca_injector_image_repository}
    tag: ${cm_images_version}
    pullPolicy: IfNotPresent

startupapicheck:
  image:
    repository: ${cm_ctl_image_repository}
    tag: ${cm_images_version}
    pullPolicy: IfNotPresent