resource "kubernetes_deployment_v1" "result" {
  metadata {
    name = "result"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "result"
      }
    }

    template {
      metadata {
        name = "result"

        labels = {
          app   = "result"
          Tier  = "frontend"
          Tier2 = "backend"
        }
      }

      spec {
        container {
          image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.google_artifact_registry_name}/result"
          name  = "result"

          port {
            container_port = 4000
          }
        }
      }
    }
  }
}


resource "kubernetes_service_v1" "result" {
  metadata {
    name = "result"

    labels = {
      Tier  = "frontend"
      Tier2 = "backend"
    }
  }

  spec {
    type = "LoadBalancer"

    port {
      port        = 4000
      target_port = 4000
    }

    selector = {
      app = "result"
    }
  }
}
