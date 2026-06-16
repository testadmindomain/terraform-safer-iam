output "namespace" {
  value = kubernetes_namespace.this.metadata[0].name
}

output "ksa_name" {
  value = kubernetes_service_account.this.metadata[0].name
}

output "orchestration_deployment" {
  value = kubernetes_deployment.orchestration.metadata[0].name
}

output "csam_classifier_deployment" {
  value = kubernetes_deployment.csam_classifier.metadata[0].name
}