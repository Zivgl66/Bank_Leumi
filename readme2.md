Here’s a README structure for your `Bank_Leumi` repo that explains how to use the repository step by step:

---

# Bank Leumi Infrastructure Setup

This repository contains the infrastructure code to deploy and manage the Bank Leumi application using Terraform, Jenkins, and ArgoCD. The infrastructure includes both development and production environments, managed through workspaces.

## Prerequisites

Before running the setup, make sure you have the following tools installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- [Jenkins](https://www.jenkins.io/download/)

Make sure you have the proper AWS credentials configured for Terraform to interact with AWS resources.

## Setup Instructions

### 1. Deploy Supply Chain in Development Workspace

To set up the supply chain infrastructure in the development environment:

```bash
cd terraform/
terraform init
terraform workspace new development
terraform workspace select development
terraform apply
```

This will deploy the necessary resources for the development environment.

### 2. Deploy Production Workspace (Without Load Balancer Module)

To deploy the production environment, excluding the load balancer:

```bash
terraform workspace new production
terraform workspace select production
terraform apply -target=module.production_ec2
```

> **Note**: The EC2 instance in the production environment will have Apache2 installed and can only be accessed from the Bank Leumi IP `91.231.246.50`.

### 3. Deploy Load Balancer Module

Once the production resources are up, you can deploy the load balancer module:

```bash
terraform apply -target=module.load_balancer
```

### 4. ArgoCD Setup

If ArgoCD is not already installed, you can apply the manifests in the Kubernetes folder:

```bash
kubectl apply -f kubernetes/
```

ArgoCD will manage the application deployments going forward.

### 5. Deploying Application from GitHub

Once the infrastructure is deployed, you can push changes to the application repository located at:

- [example-python-web-app](https://github.com/Zivgl66/example-python-web-app)

Each push will trigger a Jenkins pipeline through a webhook, which:

1. Builds the new Docker image.
2. Pushes the image to AWS Elastic Container Registry (ECR).
3. ArgoCD will then sync and deploy the new pod to AWS Elastic Kubernetes Service (EKS).

### 6. Configure Jenkins Webhook

To enable the GitHub webhook that triggers the Jenkins pipeline, set the correct Jenkins master IP in the GitHub repository settings.

1. Go to your GitHub repository settings for `example-python-web-app`.
2. Add a webhook with the correct Jenkins master IP and point it to `/github-webhook/`.

This will ensure Jenkins listens for the changes and triggers the build pipeline.

---

Feel free to adjust the sections as per your specific use case. Let me know if you need any further refinements!
