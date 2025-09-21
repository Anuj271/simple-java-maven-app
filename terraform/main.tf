provider "google" {
  project = "your-project-id"
  region  = "us-central1"
}

provider "kubernetes" {
  host                   = google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth.0.cluster_ca_certificate)
}

data "google_client_config" "default" {}

# --------------------------
# Create GKE Cluster
# --------------------------
resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-central1-a"

  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# --------------------------
# Kubernetes Deployment
# --------------------------
resource "kubernetes_deployment" "app" {
  metadata {
    name = "my-java-app"
    labels = {
      app = "java-app"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "java-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "java-app"
        }
      }

      spec {
        container {
          name  = "java-container"
          image = "${var.image}:${var.image_tag}"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

# --------------------------
# Kubernetes Service (External IP)
# --------------------------
resource "kubernetes_service" "app_svc" {
  metadata {
    name = "java-service"
  }

  spec {
    selector = {
      app = "java-app"
    }

    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 8080
    }
  }
}
