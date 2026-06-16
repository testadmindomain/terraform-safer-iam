variable "project_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "force_destroy" {
  type    = bool
  default = false
}