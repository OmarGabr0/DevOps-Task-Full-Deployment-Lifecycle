# DevOps-Task-Full-Deployment-Lifecycle 
🚀 Automated Microservices Deployment with Kubernetes & Helm
This project was developed during my DevOps Internship at Al-Ahly Momkn (Fintech). It demonstrates a complete automated workflow for containerizing, deploying, and managing microservices using Docker, Kubernetes, Helm, and Bash scripting.

📋 Project Overview
The goal was to migrate three microservices into a Kubernetes environment while ensuring data persistence, external accessibility via Ingress, and automated lifecycle management.

🛠️ Tech Stack
Containerization: Docker

Orchestration: Kubernetes (K8s)

Package Management: Helm v3

Scripting: Bash (Advanced Automation)

Ingress Controller: Nginx

Storage: Persistent Volumes (PV) & Persistent Volume Claims (PVC)

🏗️ Key Features
1. Containerization Strategy
Created optimized Dockerfiles for multiple services.

Managed image versioning and pushed to Docker Hub.

Handled multi-service tagging for different environments.

2. Helm Chart Architecture
Designed a modular Helm structure for each application:

templates/deployment.yaml: Managed replicas and container specs.

templates/service.yaml: Internal communication.

templates/hpa.yaml: Horizontal Pod Autoscaling based on CPU/RAM.

values.yaml: Externalized configuration for environment flexibility.

3. Networking & Storage
Ingress (Nginx): Configured Ingress rules to route external traffic to services.

Persistent Storage: Implemented PV and PVC to ensure database/log data survives pod restarts.

ExternalName Services: Managed connectivity to external resources.

4. Automation Scripts (The "Engine")
I developed two core scripts to eliminate manual errors:

Deploy.sh:

Automates Docker Build, Tag, and Push.

Triggers helm upgrade --install to update the cluster.

Includes automatic login checks and error handling.

Rollout.sh:

Enables one-click rollbacks to specific revisions.

Provides a safety net for production deployments.
