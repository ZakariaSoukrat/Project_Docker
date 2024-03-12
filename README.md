# Application Deployment Using Docker Compose

## Overview

This guide outlines the steps to deploy the voting application using Docker Compose. Our application architecture is designed for scalability and ease of deployment, as illustrated below:

![Application Architecture](login-nuage-voting.drawio.svg)

## Prerequisites

- Docker and Docker Compose installed on your system
- Basic understanding of Docker concepts

## Deployment Steps

1. **Clone the Repository**  
   Clone this repository to your local system to get started with the deployment.
   ```
   git clone https://github.com/ZakariaSoukrat/Project_Docker.git
   cd Project_Docker
   ```

2. **Navigate to the Deployment Branch**  
   Make sure you're on the correct branch that contains the Docker Compose setup.
   ```
   git checkout Partie_Docker
   ```

3. **Deploy Using Docker Compose**  
   Use Docker Compose to deploy the application components. This command will build and start all the services defined in `docker-compose.yml`.
   ```
   docker-compose up -d
   ```

4. **Verify the Deployment**  
   After deploying, you can verify that all services are up and running by executing:
   ```
   docker-compose ps
   ```

## Components

The application is composed of the following services:

- **Vote**: A front-end web application for collecting votes.
- **Worker**: A .NET worker that processes votes and stores them.
- **Result**: A Node.js web application that displays the voting results.
- **Redis**: An in-memory database used as a temporary store for the votes.
- **DB**: A PostgreSQL database used for storing the processed votes.
- **Nginx**: A reverse proxy to route requests to the appropriate service.

## Architecture Diagram

The architecture diagram embedded at the beginning of this README provides a visual overview of how the components interact with each other.

## Conclusion

Following these steps will deploy the application across multiple containers, allowing for a scalable and manageable setup. For additional configuration options or troubleshooting, refer to the official Docker and Docker Compose documentation.
