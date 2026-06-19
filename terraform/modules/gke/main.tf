resource "google_container_cluster" "this" {
  project  = var.project_id
  name     = var.cluster_name
  location = var.region

  network    = var.network_self_link
  subnetwork = var.subnet_self_link

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false

  networking_mode = "VPC_NATIVE"

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  secret_manager_config {
    enabled = true
  }

  logging_config {
    enable_components = [
      "SYSTEM_COMPONENTS",
      "WORKLOADS"
    ]
  }

  monitoring_config {
    enable_components = [
      "SYSTEM_COMPONENTS"
    ]

    managed_prometheus {
      enabled = true
    }
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }
  }

  release_channel {
    channel = "UNSPECIFIED"
  }
}

resource "google_container_node_pool" "primary" {
  project  = var.project_id
  name     = "${var.cluster_name}-primary-pool"
  cluster  = google_container_cluster.this.name
  location = var.region

  initial_node_count = var.node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair  = false
    auto_upgrade = false
  }

  node_config {
    machine_type = var.machine_type

    disk_type    = "pd-balanced"
    disk_size_gb = 50

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }

    labels = {
      service = "safer-predict"
    }
  }
}