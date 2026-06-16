resource "helm_release" "this" {
  name             = "safer-predict"
  chart            = "${path.root}/../../charts/safer-predict"
  namespace        = var.namespace
  create_namespace = false

  values = [
    yamlencode({
      namespace = {
        name = var.namespace
      }

      serviceAccount = {
        name              = var.ksa_name
        gcpServiceAccount = var.gsa_email
      }

      project = {
        id          = var.project_id
        environment = var.environment
      }

      images = {
        orchestration = {
          repository = var.orchestration_image_repository
          tag        = var.orchestration_image_tag
          pullPolicy = "IfNotPresent"
        }

        csamClassifier = {
          repository = var.csam_classifier_image_repository
          tag        = var.csam_classifier_image_tag
          pullPolicy = "IfNotPresent"
        }
      }

      replicaCount = {
        orchestration = var.orchestration_replicas
        csamClassifier = var.csam_classifier_replicas
      }

      metrics = {
        environment = var.metrics_environment
      }

      pubsub = {
        projectName = var.project_id

        orchestration = {
          inputSubscription = var.orchestration_input_subscription
          csamClassifierTopic = var.csam_classifier_topic
          pertinentTopic = var.results_pertinent_topic
          notPertinentTopic = var.results_not_pertinent_topic
        }

        csamClassifier = {
          inputSubscription = var.csam_classifier_subscription
          outputTopic = var.orchestration_callback_topic
        }
      }

      gcs = {
        projectName = var.project_id
        userAgent = "mabrook-safer"
      }

      url = {
        httpsOnly = "1"
        connectTimeout = "5"
        readTimeout = "30"
        fileSizeLimit = var.media_file_size_limit
      }

      classifier = {
        imagePrecision = var.image_classifier_precision
        videoPrecision = var.video_classifier_precision
      }
    })
  ]
}