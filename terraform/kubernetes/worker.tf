resource "kubernetes_deployment_v1" "worker" {
  metadata {
    name = "worker"
  }

  spec {
    replicas = 1

    template {
      metadata {
        name = "worker"

        labels = {
          app  = "worker"
          Tier = "backend"
        }
      }

      spec {
        container {
          image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.google_artifact_registry_name}/worker"
          name  = "worker"
        }
      }
    }

    selector {
      match_labels = {
        app = "worker"
      }
    }
  }
}
