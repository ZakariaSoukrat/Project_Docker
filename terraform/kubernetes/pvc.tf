resource "kubernetes_persistent_volume_claim" "postgres_pvc" {
    metadata {
        name = "postgres-pvc"
    }

    spec {
        storage_class_name = "standard"

        resources {
            requests = {
                storage = "500Mi"
            }
        }

        access_modes = ["ReadWriteOnce"]
    }
}
