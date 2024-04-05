resource "docker_image" "result" {
  name = "result"
  build {
    context = "../result/"
  }
}

resource "docker_container" "result" {
  name  = "result"
  image = docker_image.result.image_id
  ports {
    internal = "4000"
    external = "4000"
  }
  networks_advanced {
    name = docker_network.frontend_network.name
  }
  networks_advanced {
    name = docker_network.backend_network.name
  }
  depends_on = [docker_container.db]
}
