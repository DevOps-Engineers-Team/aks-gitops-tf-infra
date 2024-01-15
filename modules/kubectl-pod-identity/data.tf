data "template_file" "azure_assigned_identities" {
    template = file("${path.module}/manifests/01-azureassignedidentities.yaml.tpl")
}

data "template_file" "azure_identities" {
    template = file("${path.module}/manifests/02-azureidentities.yaml.tpl")
}

data "template_file" "azure_identity_bindings" {
    template = file("${path.module}/manifests/03-azureidentitybindings.yaml.tpl")
}

data "template_file" "azure_pod_identity_exceptions" {
    template = file("${path.module}/manifests/04-azurepodidentityexceptions.yaml.tpl")
}

data "template_file" "nmi_ds" {
    template = file("${path.module}/manifests/05-nmi-ds.yaml.tpl")
    vars = {
        image = var.nmi_ds_image
    }
}

data "template_file" "mic_deploy" {
    template = file("${path.module}/manifests/06-mic-deploy.yaml.tpl")
    vars = {
        image = var.mic_deploy_image
    }
}