locals {
  namespace = "safer-predict-${var.environment}"
}

module "network" {
  source = "../../modules/network"

  project_id   = var.project_id
  region       = var.region
  network_name = var.network_name
  subnet_name  = var.subnet_name

  subnet_cidr   = var.subnet_cidr
  pods_cidr     = var.pods_cidr
  services_cidr = var.services_cidr
}

module "gcs" {
  source = "../../modules/gcs"

  project_id    = var.project_id
  bucket_name   = var.media_bucket_name
  location      = var.region
  environment   = var.environment
  force_destroy = true
}

module "iam" {
  source = "../../modules/iam"

  project_id  = var.project_id
  environment = var.environment

  namespace = local.namespace
  ksa_name  = "safer-predict"
}

module "pubsub" {
  source = "../../modules/pubsub"

  project_id  = var.project_id
  environment = var.environment
}

module "safer_predict" {
  source = "../../modules/safer_predict"

  namespace   = local.namespace
  project_id  = var.project_id
  environment = var.environment

  ksa_name  = "safer-predict"
  gsa_email = module.iam.service_account_email

  orchestration_image_repository = var.orchestration_image_repository
  orchestration_image_tag        = var.orchestration_image_tag

  csam_classifier_image_repository = var.csam_classifier_image_repository
  csam_classifier_image_tag        = var.csam_classifier_image_tag

  orchestration_replicas   = 1
  csam_classifier_replicas = 1

  metrics_environment   = "staging"
  media_file_size_limit = "104857600"

  image_classifier_precision = "99.9"
  video_classifier_precision = "99.9"

  orchestration_input_subscription = module.pubsub.orchestration_input_subscription
  csam_classifier_topic            = module.pubsub.csam_classifier_topic
  csam_classifier_subscription     = module.pubsub.csam_classifier_subscription
  orchestration_callback_topic     = module.pubsub.input_topic
  results_pertinent_topic          = module.pubsub.results_pertinent_topic
  results_not_pertinent_topic      = module.pubsub.results_not_pertinent_topic

  depends_on = [
    module.gke,
    module.iam,
    module.pubsub,
    module.secrets,
    module.gcs
  ]
}

module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  region       = var.region
  zone         = var.zone
  cluster_name = var.cluster_name

  network_self_link = module.network.network_self_link
  subnet_self_link  = module.network.subnet_self_link

  pods_range_name     = module.network.pods_range_name
  services_range_name = module.network.services_range_name

  node_count     = var.node_count
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count

  machine_type = "e2-standard-4"
}

module "secrets" {
  source = "../../modules/secrets"

  project_id  = var.project_id
  environment = var.environment

  secret_names = [
    "CUSTOMER_NAME",
    "METRICS_USER",
    "METRICS_PASSWORD"
  ]
}