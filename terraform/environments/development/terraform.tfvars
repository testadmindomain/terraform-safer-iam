project_id  = "wired-strategy-457015-b1"
region      = "europe-central2"
environment = "development"

network_name = "safer-development-vpc"
subnet_name  = "safer-development-subnet"

cluster_name = "safer-development-cluster"

resource_prefix = "safer-development"

subnet_cidr   = "10.60.0.0/20"
pods_cidr     = "10.61.0.0/16"
services_cidr = "10.62.0.0/20"

media_bucket_name = "mabrook-safer-development-media"

orchestration_image_repository = "europe-central2-docker.pkg.dev/mabrook-safer-development/safer/safer-orchestration"
orchestration_image_tag        = "<version>"

csam_classifier_image_repository = "europe-central2-docker.pkg.dev/mabrook-safer-development/safer/csam-classifier-pipeline"
csam_classifier_image_tag        = "<version>"

