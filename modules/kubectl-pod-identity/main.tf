resource "kubectl_manifest" "azure_assigned_identities" {
    yaml_body = data.template_file.azure_assigned_identities.rendered
}

resource "kubectl_manifest" "azure_identities" {
    depends_on = [kubectl_manifest.azure_assigned_identities]
    yaml_body = data.template_file.azure_identities.rendered
}

resource "kubectl_manifest" "azure_identity_bindings" {
    depends_on =[kubectl_manifest.azure_identities]
    yaml_body = data.template_file.azure_identity_bindings.rendered
}

resource "kubectl_manifest" "azure_pod_identity_exceptions" {
    depends_on =[kubectl_manifest.azure_identity_bindings]
    yaml_body = data.template_file.azure_pod_identity_exceptions.rendered
}

resource "kubectl_manifest" "nmi_ds" {
    depends_on =[kubectl_manifest.azure_pod_identity_exceptions]
    yaml_body = data.template_file.nmi_ds.rendered
}

resource "kubectl_manifest" "mic_deploy" {
    depends_on =[kubectl_manifest.nmi_ds]
    yaml_body = data.template_file.mic_deploy.rendered
}
