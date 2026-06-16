variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type    = string
  default = "10.60.0.0/20"
}

variable "pods_cidr" {
  type    = string
  default = "10.61.0.0/16"
}

variable "services_cidr" {
  type    = string
  default = "10.62.0.0/20"
}