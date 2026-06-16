project_id  = "mabrook-safer-development"
region      = "europe-central2"
environment = "development"

network_name = "safer-development-vpc"
subnet_name  = "safer-development-subnet"

cluster_name = "safer-development-cluster"

media_bucket_name = "safer-development-media"

resource_prefix = "safer-development"

subnet_cidr   = "10.60.0.0/20"
pods_cidr     = "10.61.0.0/16"
services_cidr = "10.62.0.0/20"

media_bucket_name = "mabrook-safer-development-media"

orchestration_image   = "europe-central2-docker.pkg.dev/mabrook-safer-development/safer/safer-orchestration:<version>"
csam_classifier_image = "europe-central2-docker.pkg.dev/mabrook-safer-development/safer/csam-classifier-pipeline:<version>"


cluster_name = "safer-development-cluster"