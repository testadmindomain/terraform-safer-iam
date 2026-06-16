output "project_id" {
  value = var.project_id
}

output "region" {
  value = var.region
}

output "environment" {
  value = var.environment
}

output "network_name" {
  value = module.network.network_name
}

output "subnet_name" {
  value = module.network.subnet_name
}

output "media_bucket_name" {
  value = module.gcs.bucket_name
}

output "media_bucket_url" {
  value = module.gcs.bucket_url
}

output "secret_ids" {
  value = module.secrets.secret_ids
}

