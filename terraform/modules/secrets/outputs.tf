output "secret_ids" {
  value = {
    for key, secret in google_secret_manager_secret.this :
    key => secret.secret_id
  }
}

output "secret_names" {
  value = {
    for key, secret in google_secret_manager_secret.this :
    key => secret.name
  }
}