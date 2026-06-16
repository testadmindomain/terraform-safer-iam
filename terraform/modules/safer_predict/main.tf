resource "kubernetes_namespace" "this" {
  metadata {
    name = var.namespace

    labels = {
      environment = var.environment
      service     = "safer-predict"
      managed-by  = "terraform"
    }
  }
}

resource "kubernetes_service_account" "this" {
  metadata {
    name      = var.ksa_name
    namespace = kubernetes_namespace.this.metadata[0].name

    annotations = {
      "iam.gke.io/gcp-service-account" = var.gsa_email
    }

    labels = {
      environment = var.environment
      service     = "safer-predict"
      managed-by  = "terraform"
    }
  }
}

resource "kubernetes_deployment" "orchestration" {
  metadata {
    name      = "safer-orchestration"
    namespace = kubernetes_namespace.this.metadata[0].name

    labels = {
      app         = "safer-orchestration"
      environment = var.environment
      service     = "safer-predict"
    }
  }

  spec {
    replicas = var.orchestration_replicas

    selector {
      match_labels = {
        app = "safer-orchestration"
      }
    }

    template {
      metadata {
        labels = {
          app         = "safer-orchestration"
          environment = var.environment
          service     = "safer-predict"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.this.metadata[0].name

        container {
          name              = "safer-orchestration"
          image             = var.orchestration_image
          image_pull_policy = "IfNotPresent"

          env {
            name  = "ENABLE_API_ONLY_MODE"
            value = "0"
          }

          env {
            name  = "QUEUEING_SOLUTION"
            value = "PUBSUB"
          }

          env {
            name  = "GCPPUBSUB_PROJECT_NAME"
            value = var.project_id
          }

          env {
            name  = "QUEUE_INPUT_QUEUE"
            value = var.orchestration_input_subscription
          }

          env {
            name  = "QUEUE_CSAM_CLASSIFIER_QUEUE"
            value = var.csam_classifier_topic
          }

          env {
            name  = "QUEUE_PERTINENT_QUEUE"
            value = var.results_pertinent_topic
          }

          env {
            name  = "QUEUE_NOT_PERTINENT_QUEUE"
            value = var.results_not_pertinent_topic
          }

          env {
            name  = "METRICS_ENVIRONMENT"
            value = var.metrics_environment
          }

          env {
            name  = "LOG_FORMAT"
            value = "JSON"
          }

          env {
            name  = "LOG_LEVEL"
            value = "INFO"
          }

          env {
            name  = "GCS_PROJECT_NAME"
            value = var.project_id
          }

          env {
            name  = "GCS_USER_AGENT"
            value = "mabrook-safer"
          }

          env {
            name  = "URL_HTTPS_ONLY"
            value = "1"
          }

          env {
            name  = "URL_CONNECT_TIMEOUT"
            value = "5"
          }

          env {
            name  = "URL_READ_TIMEOUT"
            value = "30"
          }

          env {
            name  = "URL_FILE_SIZE_LIMIT"
            value = var.media_file_size_limit
          }

          # TODO:
          # CUSTOMER_NAME, METRICS_USER, METRICS_PASSWORD
          # подключим через Secret Manager CSI Driver после GKE-модуля.

          resources {
            requests = {
              cpu    = "500m"
              memory = "512Mi"
            }

            limits = {
              cpu    = "1000m"
              memory = "1Gi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "csam_classifier" {
  metadata {
    name      = "csam-classifier"
    namespace = kubernetes_namespace.this.metadata[0].name

    labels = {
      app         = "csam-classifier"
      environment = var.environment
      service     = "safer-predict"
    }
  }

  spec {
    replicas = var.csam_classifier_replicas

    selector {
      match_labels = {
        app = "csam-classifier"
      }
    }

    template {
      metadata {
        labels = {
          app         = "csam-classifier"
          environment = var.environment
          service     = "safer-predict"
        }
      }

      spec {
        service_account_name = kubernetes_service_account.this.metadata[0].name

        container {
          name              = "csam-classifier"
          image             = var.csam_classifier_image
          image_pull_policy = "IfNotPresent"

          env {
            name  = "ENABLE_API_ONLY_MODE"
            value = "0"
          }

          env {
            name  = "QUEUEING_SOLUTION"
            value = "PUBSUB"
          }

          env {
            name  = "GCPPUBSUB_PROJECT_NAME"
            value = var.project_id
          }

          env {
            name  = "QUEUE_INPUT_QUEUE"
            value = var.csam_classifier_subscription
          }

          env {
            name  = "QUEUE_OUTPUT_QUEUE"
            value = var.orchestration_callback_topic
          }

          env {
            name  = "IMAGE_CLASSIFIER_PRECISION"
            value = "0.999"
          }

          env {
            name  = "VIDEO_CLASSIFIER_PRECISION"
            value = "0.999"
          }

          env {
            name  = "METRICS_ENVIRONMENT"
            value = var.metrics_environment
          }

          env {
            name  = "LOG_FORMAT"
            value = "JSON"
          }

          env {
            name  = "LOG_LEVEL"
            value = "INFO"
          }

          env {
            name  = "GCS_PROJECT_NAME"
            value = var.project_id
          }

          env {
            name  = "GCS_USER_AGENT"
            value = "mabrook-safer"
          }

          env {
            name  = "URL_HTTPS_ONLY"
            value = "1"
          }

          env {
            name  = "URL_CONNECT_TIMEOUT"
            value = "5"
          }

          env {
            name  = "URL_READ_TIMEOUT"
            value = "30"
          }

          env {
            name  = "URL_FILE_SIZE_LIMIT"
            value = var.media_file_size_limit
          }

          # TODO:
          # CUSTOMER_NAME, METRICS_USER, METRICS_PASSWORD
          # подключим через Secret Manager CSI Driver после GKE-модуля.

          resources {
            requests = {
              cpu    = "2000m"
              memory = "2Gi"
            }

            limits = {
              cpu    = "4000m"
              memory = "4Gi"
            }
          }
        }
      }
    }
  }
}