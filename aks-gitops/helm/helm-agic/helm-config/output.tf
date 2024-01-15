output "helm_values" {
  value = tolist([data.template_file.init.rendered])
}
