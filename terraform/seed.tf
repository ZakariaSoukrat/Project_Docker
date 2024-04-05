resource "docker_image" "seed" {
  name = "seed"
  build {
    context = "../seed-data/"
  }
  depends_on = [ docker_container.nginx ]
}

resource "docker_container" "seed" {
  name  = "seed"
  image = docker_image.seed.image_id
  networks_advanced {
    name = docker_network.frontend_network.name
  }
  depends_on = [ docker_container.nginx ]
}
