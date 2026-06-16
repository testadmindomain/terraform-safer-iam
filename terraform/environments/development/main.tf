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
}

module "pubsub" {
  source = "../../modules/pubsub"

  project_id  = var.project_id
  environment = var.environment
}

module "safer_predict" {
  source = "../../modules/safer_predict"

  namespace   = "safer-predict-development"
  project_id  = var.project_id
  environment = var.environment

  gsa_email = module.iam.service_account_email

  orchestration_image    = var.orchestration_image
  csam_classifier_image  = var.csam_classifier_image

  orchestration_replicas   = 1
  csam_classifier_replicas = 1

  metrics_environment  = "staging"
  media_file_size_limit = "104857600"

  orchestration_input_subscription = module.pubsub.orchestration_input_subscription
  csam_classifier_topic            = module.pubsub.csam_classifier_topic
  csam_classifier_subscription     = module.pubsub.csam_classifier_subscription
  orchestration_callback_topic     = module.pubsub.orchestration_callback_topic
  results_pertinent_topic          = module.pubsub.results_pertinent_topic
  results_not_pertinent_topic      = module.pubsub.results_not_pertinent_topic
}

module "gke" {
  source = "../../modules/gke"

  project_id   = var.project_id
  region       = var.region
  cluster_name = var.cluster_name

  network_self_link = module.network.network_self_link
  subnet_self_link  = module.network.subnet_self_link

  pods_range_name     = module.network.pods_range_name
  services_range_name = module.network.services_range_name

  node_count     = 3
  min_node_count = 3
  max_node_count = 6

  machine_type = "e2-standard-2"
}