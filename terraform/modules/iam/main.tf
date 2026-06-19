resource "google_service_account" "safer_predict" {
  project      = var.project_id

  account_id   = "safer-predict-${var.environment}"

  display_name = "Safer Predict ${var.environment}"
}

resource "google_project_iam_member" "pubsub_publisher" {
  project = var.project_id

  role   = "roles/pubsub.publisher"
  member = "serviceAccount:${google_service_account.safer_predict.email}"
}

resource "google_project_iam_member" "pubsub_subscriber" {
  project = var.project_id

  role   = "roles/pubsub.subscriber"
  member = "serviceAccount:${google_service_account.safer_predict.email}"
}

resource "google_project_iam_member" "storage_viewer" {
  project = var.project_id

  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.safer_predict.email}"
}

resource "google_project_iam_member" "secret_accessor" {
  project = var.project_id

  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.safer_predict.email}"
}

resource "google_project_iam_member" "monitoring_viewer" {
  project = var.project_id

  role   = "roles/monitoring.viewer"
  member = "serviceAccount:${google_service_account.safer_predict.email}"
}

resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.project_id

  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${google_service_account.safer_predict.email}"
}