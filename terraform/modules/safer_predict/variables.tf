variable "namespace" {
  type = string
}

variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "ksa_name" {
  type    = string
  default = "safer-predict"
}

variable "gsa_email" {
  type = string
}

variable "orchestration_image" {
  type = string
}

variable "csam_classifier_image" {
  type = string
}

variable "orchestration_replicas" {
  type    = number
  default = 1
}

variable "csam_classifier_replicas" {
  type    = number
  default = 1
}

variable "metrics_environment" {
  type = string
}

variable "media_file_size_limit" {
  type    = string
  default = "104857600"
}

variable "orchestration_input_subscription" {
  type = string
}

variable "csam_classifier_topic" {
  type = string
}

variable "csam_classifier_subscription" {
  type = string
}

variable "orchestration_callback_topic" {
  type = string
}

variable "results_pertinent_topic" {
  type = string
}

variable "results_not_pertinent_topic" {
  type = string
}