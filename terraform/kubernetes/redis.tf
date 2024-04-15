resource "kubernetes_deployment_v1" "redis" {
  metadata {
    name = "redis"
    labels = {
      app  = "redis"
      Tier = "backend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "redis"
      }
    }

    template {
      metadata {
        labels = {
          app  = "redis"
          Tier = "backend"
        }
      }

      spec {
        container {
          image = "redis:alpine"
          name  = "redis"
          port {
            container_port = 6379
          }
        }
      }
    }
  }
}





resource "kubernetes_service_v1" "redis" {
  metadata {
    name = "redis"
    labels = {
      Tier = "backend"
    }
  }

  spec {
    type = "ClusterIP"

    port {
      port = 6379
      target_port = 6379
    }

    selector = {
      app = "redis"
    }
  }
}
