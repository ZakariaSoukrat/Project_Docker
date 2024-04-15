resource "kubernetes_deployment_v1" "vote" {
  metadata {
    labels = {
      app   = "vote"
      Tier  = "frontend"
      Tier2 = "backend"
    }
    name = "vote"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "vote"
      }
    }

    template {
      metadata {
        labels = {
          app   = "vote"
          Tier  = "frontend"
          Tier2 = "backend"
        }
      }

      spec {
        container {
          image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.google_artifact_registry_name}/vote"
          name  = "vote"

          port {
            container_port = 5000
          }

          env {
            name  = "OPTION_A"
            value = "Cats"
          }

          env {
            name  = "OPTION_B"
            value = "Dogs"
          }
        }
      }
    }
  }
}



resource "kubernetes_service_v1" "nginx" {
  metadata {
    name = "nginx"
    labels = {
      Tier  = "frontend"
      Tier2 = "backend"
    }
  }

  spec {
    type = "LoadBalancer"

    port {
      port        = 8000
      target_port = 5000
    }

    selector = {
      app = "vote"
    }
  }
}
