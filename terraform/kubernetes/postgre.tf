resource "kubernetes_deployment_v1" "db-dep" {
  metadata {
    name = "db"
    labels = {
      app  = "db"
      Tier = "backend"
    }
  }

  spec {
    replicas = 1

    template {
      metadata {
        name = "db"
        labels = {
          app = "db"
          Tier = "backend"
        }
      }

      spec {
        container {
          image = "postgres:alpine"
          name  = "db"

          volume_mount {
            name       = "vote-data"
            mount_path = "/var/lib/postgresql/data"
            sub_path   = "data"
            read_only  = false
          }

          env {
            name  = "POSTGRES_DB"
            value = "voting-app-db"
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = "postgres"
          }

          port {
            container_port = 5432
          }
        }

        volume {
          name = "vote-data"

          persistent_volume_claim {
            claim_name = "postgres-pvc"
          }
        }
      }
    }

    selector {
      match_labels = {
        app = "db"
      }
    }
  }
}

resource "kubernetes_service_v1" "db-svc" {
  metadata {
    name = "db"
    labels = {
      Tier = "backend"
    }
  }
  spec {
    type = "ClusterIP"
    port{
      port        = 5432
      target_port = 5432
    }
    selector = {
      app = "db"
    }
  }
}