resource "google_secret_manager_secret" "this" {
  for_each = toset(var.secret_names)

  project   = var.project_id
  secret_id = "${lower(each.value)}-${var.environment}"

  replication {
    auto {}
  }

  labels = {
    environment = var.environment
    service     = "safer-predict"
    managed_by  = "terraform"
  }
}