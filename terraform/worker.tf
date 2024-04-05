resource "docker_image" "worker" {
  name = "worker"
  build {
    context = "../worker/"
  }
  
}
resource "docker_container" "worker" {
  name  = "worker"
  image = docker_image.worker.image_id
  networks_advanced {
    name = docker_network.backend_network.name
  }
}
