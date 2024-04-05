resource "docker_network" "back-tier" {
  name = "back-tier"
}

resource "docker_network" "front-tier" {
  name = "front-tier"
}
