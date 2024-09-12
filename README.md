# Bank Leumi

This repository contains the code for the Bank Leumi project, designed to implement and manage banking operations using a cloud infrastructure with a focus on security, scalability, and automation.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Components](#components)
3. [Infrastructure Setup](#infrastructure-setup)
4. [Deployment](#deployment)
5. [Usage](#usage)
6. [Technologies Used](#technologies-used)
7. [Contributing](#contributing)
8. [License](#license)

## Project Overview

The Bank Leumi project simulates a banking system with a cloud-based infrastructure. This project focuses on creating an efficient and secure environment for managing banking services. The repository is organized to facilitate easy deployment, management, and scaling of services using best DevOps practices.

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

To set up the infrastructure:

1. Clone this repository:

   ```bash
   git clone https://github.com/Zivgl66/Bank_Leumi.git
   cd Bank_Leumi
   ```

2. Ensure you have Terraform installed and configured. Run the following to initialize and apply the infrastructure:

   ```bash
   terraform init
   terraform apply
   ```

3. Terraform will provision the AWS infrastructure, including an EKS cluster and deploying ArgoCD.

4. Before applying the `application.yaml` for ArgoCD, **update the `destination.server` field** in the `application.yaml` file to the DNS of your EKS cluster. The section to update looks like this:

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

## Deployment

Deployment is done automatically by ArgoCD.

## Usage

After deployment, the Python Flask application will be accessible at:

```
https://<your-service-url>:443
```

Replace `<your-service-url>` with the DNS or IP assigned to your Kubernetes service.

You can interact with the API via standard HTTP methods (`GET`, `POST`, etc.) for different banking operations.

## Technologies Used

- **Python**: Backend application
- **Flask**: Micro web framework
- **Kubernetes**: Container orchestration
- **Terraform**: Infrastructure as Code (IaC) tool for managing cloud infrastructure
- **ArgoCD**: Continuous deployment tool, installed via Terraform
- **AWS EKS**: Managed Kubernetes service on AWS
- **Jenkins/CircleCI**: Continuous Integration/Continuous Deployment pipelines

## Contributing

Contributions are welcome! Please open an issue or submit a pull request if you have suggestions for improvements or new features.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
