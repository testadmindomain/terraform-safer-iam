output "helm_release_name" {
  value = helm_release.this.name
}

output "helm_release_version" {
  value = helm_release.this.version
}

output "namespace" {
  value = var.namespace
}