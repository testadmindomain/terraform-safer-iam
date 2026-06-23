project_id  = "wired-strategy-457015-b1"
region      = "me-central1"
zone        = "me-central1-a"
environment = "development"

network_name = "safer-development-vpc"
subnet_name  = "safer-development-subnet"

cluster_name = "safer-development-cluster"

resource_prefix = "safer-development"

subnet_cidr   = "10.60.0.0/20"
pods_cidr     = "10.61.0.0/16"
services_cidr = "10.62.0.0/20"

node_count     = 1
min_node_count = 1
max_node_count = 3

media_bucket_name = "mabrook-safer-development-media"

orchestration_image_repository = "me-central1-docker.pkg.dev/wired-strategy-457015-b1/safer/safer-orchestration"
orchestration_image_tag        = "1.0.0"

csam_classifier_image_repository = "me-central1-docker.pkg.dev/wired-strategy-457015-b1/safer/csam-classifier-pipeline"
csam_classifier_image_tag        = "1.0.0"

