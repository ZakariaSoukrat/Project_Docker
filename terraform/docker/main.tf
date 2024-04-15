variable "project_path" {
  type        = string
  description = "Path to the root of the project"
}

# Redis database
resource "docker_image" "redis" {
    name = "docker.io/redis:7.2-alpine"
}

resource "docker_container" "redis" {
    name = "redis"
    image = docker_image.redis.image_id
    networks_advanced {
        name = "back-tier"
    }
    ports {
        internal = "6379"
        external = "6379"
    }
}

# Postgres database
resource "docker_image" "postgres" {
    name = "docker.io/postgres:16.2-alpine3.19"
}

resource "docker_container" "db" {
    name = "db"
    image = docker_image.postgres.image_id
    ports {
        internal = "5432"
        external = "5432"
    }
    networks_advanced {
        name = "back-tier"
    }
    env = [
        "POSTGRES_USER=postgres",
        "POSTGRES_PASSWORD=postgres",
        "POSTGRES_DB=postgres"
    ]
    volumes {
        container_path = "/var/lib/postgresql/data"
        volume_name = docker_volume.db-data.name
    }
}

# Nginx proxy
resource "docker_image" "nginx" {
    name = "docker.io/nginx:1.25-alpine"
}

resource "docker_container" "nginx" {
    name = "nginx"
    image = docker_image.nginx.image_id
    ports {
        internal = "8000"
        external = "8000"
    }
    networks_advanced {
        name = "front-tier"
    }
    volumes {
        container_path = "/etc/nginx"
        host_path = "${var.project_path}/nginx"
        read_only = true
    }
    depends_on = [ docker_container.vote1, docker_container.vote2 ]
}

# Seed
resource "docker_image" "seed" {
    name = "seed:latest"
    build {
        context = "../seed-data"
    }
}

resource "docker_container" "seed" {
    name = "seed"
    image = docker_image.seed.image_id
    networks_advanced {
        name = "front-tier"
    }
    depends_on = [
        docker_container.nginx
    ]
}

# Vote
resource "docker_image" "vote" {
    name = "vote"
    build {
        context = "../vote"
    }
}

resource "docker_container" "vote1" {
    name = "vote1"
    image = docker_image.vote.image_id
    networks_advanced {
        name = "front-tier"
    }
    networks_advanced {
        name = "back-tier"
    }
    depends_on = [
        docker_container.redis
    ]
}

resource "docker_container" "vote2" {
    name = "vote2"
    image = docker_image.vote.image_id
    networks_advanced {
        name = "front-tier"
    }
    networks_advanced {
        name = "back-tier"
    }
    depends_on = [
        docker_container.redis
    ]
}

# Worker
resource "docker_image" "worker" {
    name = "worker"
    build {
        context = "../worker"
    }
}

resource "docker_container" "worker" {
    name = "worker"
    image = docker_image.worker.image_id
    networks_advanced {
        name = "back-tier"
    }
    depends_on = [
        docker_container.db,
        docker_container.redis
    ]
}

# Result 
resource "docker_image" "result" {
    name = "result"
    build {
        context = "../result"
    }
}

resource "docker_container" "result" {
    name = "result"
    image = docker_image.result.image_id
    networks_advanced {
        name = "back-tier"
    }
    networks_advanced {
        name = "front-tier"
    }
    depends_on = [
        docker_container.db
    ]
    env = [ "PORT=4000" ]
    ports {
        internal = "4000"
        external = "4000"
    }
}

resource "docker_network" "front-tier" {
    name = "front-tier"
}

resource "docker_network" "back-tier" {
    name = "back-tier"
}

resource "docker_volume" "db-data" {
  name = "db-data"
}
