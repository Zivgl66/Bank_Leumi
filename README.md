# Bank Leumi

This repository contains the code for the Bank Leumi project, designed to implement and manage python app using a cloud infrastructure with a focus on security, scalability, and automation.

The repo for the python app:
https://github.com/Zivgl66/example-python-web-app

## Table of Contents

1. [Project Overview](#project-overview)
2. [Components](#components)
3. [Infrastructure Setup](#infrastructure-setup)
4. [Troubleshoot](#troubleshoot)
5. [Usage](#usage)
6. [Technologies Used](#technologies-used)
7. [Contributing](#contributing)
8. [License](#license)

## Project Overview

The Bank Leumi project simulates a web app with a cloud-based infrastructure. This project focuses on creating an efficient and secure environment for managing applications. The repository is organized to facilitate easy deployment, management, and scaling of services using best DevOps practices.

## Components

This project includes several core components:

1. **Python Flask App**: A web application running on Flask, serving as the core backend for managing banking operations. It listens on port `3333` in a Kubernetes cluster.

2. **Kubernetes Cluster**: The application is deployed on a Kubernetes cluster. The cluster is configured to run on a private subnet, ensuring a secure environment for sensitive banking operations.

3. **Kubernetes Service**: A `python-app-service` is created to expose the Flask app to the outside world via port `443`.

4. **Terraform Modules**: Infrastructure is managed using Terraform, with modularized configurations for easy management and reusability. Each module contains:

   - `main.tf`: Defines the infrastructure resources.
   - `variables.tf`: Defines the inputs for the module.
   - `outputs.tf`: Outputs the results of the module's execution.
   - `README.md`: Provides instructions for using the module.

5. **ArgoCD**: Installed via Terraform for continuous deployment, ArgoCD manages the deployment of the application to the Kubernetes cluster. You simply apply the `application.yaml` file to handle deployments.

6. **CI/CD Pipeline**: CI/CD pipelines using Jenkins or CircleCI are configured to automate deployment processes whenever changes are pushed to the repository.

## Infrastructure Setup

### Backend setup for Terraform Overview

- **S3 Bucket**: Used to store the Terraform state files securely. Storing the state in S3 allows for better collaboration and state management across multiple environments and team members.
- **DynamoDB Table**: DynamoDB is used to implement state locking, ensuring that only one Terraform operation can run at a time, preventing potential conflicts or corruption of the state file.

### How to Use

Before running any Terraform commands, the backend infrastructure must be provisioned. This is usually a one-time setup.

1. Navigate to the `tfbackend` folder:

   ```bash
   cd Terraform/tfbackend
   ```

2. Initialize and apply the Terraform configuration to create the S3 bucket and DynamoDB table:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

3. Once this infrastructure is in place, update your main Terraform configuration to point to the S3 bucket and DynamoDB table for state storage and locking.

### 1. Deploy Supply Chain in Development Workspace

To set up the supply chain infrastructure in the development environment:

```bash
cd Terraform/
terraform init
terraform workspace new development
terraform workspace select development
terraform apply -var-file="./supply_chain/terraform.tfvars"
```

This will deploy the necessary resources for the development environment.

### 2. Deploy Production Workspace (Without Load Balancer Module)

To deploy the production environment, excluding the load balancer:

```bash
terraform workspace new production
terraform workspace select production
terraform apply -var-file="./production/terraform.tfvars"
```

> **Note**: The EC2 instance in the production environment will have Apache2 installed and can only be accessed from the Bank Leumi IP `91.231.246.50`.

### 3. Deploy Load Balancer Module

Once the production resources are up, you can deploy the load balancer module:

```bash
terraform apply -target=module.load_balancer -var="create_load_balancer=true"
```

### 4. Terraform will provision the AWS infrastructure, including an EKS cluster and install ArgoCD (running the k8s manifests).

- Before applying the `application.yaml` for ArgoCD, **update the `destination.server` field** in the `application.yaml` file to the DNS of your EKS cluster. The section to update looks like this:

```yaml
destination:
  server: https://<your-cluster-dns>
```

Replace `<your-cluster-dns>` with the actual DNS endpoint for your EKS cluster.

Once this is done, apply the `application.yaml`:

```bash
kubectl apply -f application.yaml
```

> **Note**: Ensure you have set the correct context for your EKS cluster using the following command:

```bash
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

## Troubleshoot

### 1. If the cluster in not connected properly to argocd, use context to connect it:

```basah
kubectl config get-contexts
argocd cluster add <your-eks-context>
argocd cluster list
```

### 2. Install nginx ingress controller:

```basah
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/aws/deploy.yaml
```

### 3. Using HTTPS requires a tls certificate:

- Create an a tls certificate locally:

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=example.com/O=example"
kubectl create secret tls flask-tls --cert=tls.crt --key=tls.key -n python-app
```

- Apply the service for the python app and the ingress manifests:

```bash
kubectl apply -f app-service.yaml
kubectl apply -f ingress.yaml
```

- For any problem, check the ingress logs:

```bash
kubectl logs -n ingress-nginx -l app.kubernetes.io/name=ingress-nginx
kubectl get ingress -n python-app
kubectl describe ingress python-app-ingress -n python-app
kubectl get service python-app-service -n python-app
kubectl describe service python-app-service -n python-app
kubectl get pods -n python-app --show-labels
kubectl get ingressclass
```

## Usage

After deployment, the Python Flask application will be accessible at:

```
https://<your-load-balancer-dns>:443
```

Replace `<your-load-balancer-dns>` with the DNS or IP assigned to your AWS LB service.

You can interact with the API via standard HTTP methods (`GET`, `POST`, etc.) for different banking operations.

## Technologies Used

- **Python**: Backend application
- **Flask**: Micro web framework
- **Kubernetes**: Container orchestration
- **Terraform**: Infrastructure as Code (IaC) tool for managing cloud infrastructure
- **ArgoCD**: Continuous deployment tool, installed via Terraform
- **AWS EKS**: Managed Kubernetes service on AWS
- **Jenkins**: Continuous Integration/Continuous Deployment pipelines

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have suggestions for improvements or new features.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
