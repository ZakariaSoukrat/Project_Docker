# Running Our Application on Google Cloud with Kubernetes

This guide walks you through deploying our application to Google Cloud using Kubernetes. Ensure you have [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) and [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) installed on your machine before proceeding.

## Prerequisites

- Google Cloud account
- Google Cloud SDK installed
- kubectl installed
- Docker images of our application

## Authentication & Configuration

1. **Authenticate with Google Cloud:**  
   Start by authenticating your Google Cloud CLI with your Google account. Open a terminal and run:
   ```
   gcloud auth login
   ```
   Follow the prompts to authenticate.

2. **Set your Google Cloud project:**  
   Configure `gcloud` to use your project with:
   ```
   gcloud config set project login-k8s-416409
   ```

## Create and Configure Kubernetes Cluster

1. **Create a Kubernetes cluster:**  
   Use the following command to create a Kubernetes cluster named `votekube`. This cluster has 3 nodes of type `n1-standard-2` in the `europe-west9` zone.
   ```
   gcloud container clusters create votekube --machine-type n1-standard-2 --num-nodes 3 --zone europe-west9
   ```
   Alternatively, you can change the `--zone` parameter to deploy in a different region, such as `us-central1-c`.

2. **Get cluster credentials:**  
   To interact with your newly created cluster, get the credentials and configure `kubectl` using:
   ```
   gcloud container clusters get-credentials votekube --zone europe-west9  --project login-k8s-416409
   ```

## Deploying the Application

1. **Deploy your Kubernetes configurations:**  
   Navigate to the directory containing your Kubernetes configuration files and apply them:
   ```
   kubectl apply -f ./kubernetes/
   ```

2. **Verify the services are running:**  
   To ensure your application services are up and running, check the service status with:
   ```
   kubectl get svc
   ```

## Accessing the Application

- **Voting Page:** The application's voting interface is available at [http://34.28.238.188:5001/](http://34.28.238.188:5001/).

- **Results Page:** To view voting results, visit [http://34.123.46.22:4001/](http://34.123.46.22:4001/).

## Cleaning Up

To avoid incurring charges in Google Cloud, remember to delete the cluster after use:
```
gcloud container clusters delete votekube --zone europe-west9
```
Or specify a different zone if you created the cluster in another region.

## Infrastructure Overview

![image](login-nuage-voting-k8s.drawio.svg)

---

Replace the IP addresses with the actual IPs of your deployed services, and adjust any paths or names as necessary for your project. This README provides a basic framework and can be extended with more specific details about your application as needed.