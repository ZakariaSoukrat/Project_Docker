

## Instructions

### 1. Docker Compose Part

1. Run the following command to start Docker Compose:
   ```bash
   docker-compose up -d
   ```

2. Access the services at:
   - vote http://localhost:4000
   -  result http://localhost:5000

### 2. Kubernetes Part

1. Before proceeding, ensure you have created a registry and a cluster in GCP.

2. Update the URLs of the images in the `docker-compose.yaml` file to match your registry URL.

3. Authenticate to the registry:
   ```bash
   gcloud auth configure-docker europe-west9-docker.pkg.dev
   ```

4. Update the following files in the `kubernetes` directory with the new image URLs.

5. Build and push Docker Compose images:
   ```bash
   docker-compose build
   docker-compose push
   ```

6. Apply Kubernetes configurations:
   ```bash
   kubectl apply -f kubernetes/
   ```

7. To access the services, run:
   ```bash
   kubectl get services
   ```

### 3. Terraform Part

#### Part 1: Docker

1. Navigate to the `terraform/docker` directory.

2. Fill `variables.auto.tfvars` with the absolute path to the root project.

3. Run the following commands:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

#### Part 2: Kubernetes

1. Fill in the variable values in `/terraform/kubernetes/terraform.tfvars`, including the path to your credentials JSON and your project ID.

2. Run the following commands:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

##
