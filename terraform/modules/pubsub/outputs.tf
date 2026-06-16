output "topic_names" {
  value = {
    for key, topic in google_pubsub_topic.this :
    key => topic.name
  }
}

output "subscription_names" {
  value = {
    for key, sub in google_pubsub_subscription.this :
    key => sub.name
  }
}

output "orchestration_input_subscription" {
  value = google_pubsub_subscription.this["orchestration_input"].name
}

output "csam_classifier_topic" {
  value = google_pubsub_topic.this["csam_classifier"].name
}

output "csam_classifier_subscription" {
  value = google_pubsub_subscription.this["csam_classifier"].name
}

output "orchestration_callback_topic" {
  value = google_pubsub_topic.this["orchestration_callback"].name
}

output "orchestration_callback_subscription" {
  value = google_pubsub_subscription.this["orchestration_callback"].name
}

output "results_pertinent_topic" {
  value = google_pubsub_topic.this["results_pertinent"].name
}

output "results_not_pertinent_topic" {
  value = google_pubsub_topic.this["results_not_pertinent"].name
}