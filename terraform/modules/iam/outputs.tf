output "service_account_email" {
  value = google_service_account.safer_predict.email
}

output "service_account_name" {
  value = google_service_account.safer_predict.name
}