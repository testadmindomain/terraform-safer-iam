variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "resource_prefix" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "media_bucket_name" {
  type = string
}

variable "subnet_cidr" {
  type = string
}

variable "pods_cidr" {
  type = string
}

variable "services_cidr" {
  type = string
}

variable "orchestration_image_repository" {
  type = string
}

variable "orchestration_image_tag" {
  type = string
}

variable "csam_classifier_image_repository" {
  type = string
}

variable "csam_classifier_image_tag" {
  type = string
}