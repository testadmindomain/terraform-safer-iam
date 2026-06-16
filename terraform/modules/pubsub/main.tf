locals {
  topics = {
    input                  = "safer-${var.environment}-input"
    csam_classifier        = "safer-${var.environment}-csam-classifier"
    orchestration_callback = "safer-${var.environment}-orchestration-callback"
    results_pertinent      = "safer-${var.environment}-results-pertinent"
    results_not_pertinent  = "safer-${var.environment}-results-not-pertinent"
  }

  subscriptions = {
    orchestration_input = {
      name  = "safer-${var.environment}-orchestration-input-sub"
      topic = "input"
    }

    csam_classifier = {
      name  = "safer-${var.environment}-csam-classifier-sub"
      topic = "csam_classifier"
    }

    orchestration_callback = {
      name  = "safer-${var.environment}-orchestration-callback-sub"
      topic = "orchestration_callback"
    }

    results_pertinent = {
      name  = "safer-${var.environment}-results-pertinent-sub"
      topic = "results_pertinent"
    }

    results_not_pertinent = {
      name  = "safer-${var.environment}-results-not-pertinent-sub"
      topic = "results_not_pertinent"
    }
  }
}

resource "google_pubsub_topic" "this" {
  for_each = local.topics

  project = var.project_id
  name    = each.value

  labels = {
    environment = var.environment
    service     = "safer-predict"
    managed_by  = "terraform"
  }
}

resource "google_pubsub_subscription" "this" {
  for_each = local.subscriptions

  project = var.project_id
  name    = each.value.name
  topic   = google_pubsub_topic.this[each.value.topic].name

  ack_deadline_seconds = 120

  labels = {
    environment = var.environment
    service     = "safer-predict"
    managed_by  = "terraform"
  }
}