# GitOps with Jenkins and ArgoCD

This repository demonstrates a GitOps workflow using Jenkins Container and ArgoCD to deploy Kubernetes manifests to a Minikube cluster running on a Container. The project integrates Jenkins CI/CD with ArgoCD to enable automated deployments whenever changes are pushed to the GitHub repository.

## Project Overview

- **Jenkins**: Runs as a container outside the Minikube cluster to handle CI/CD tasks
- **Minikube**: Serves as the Kubernetes cluster, with Docker as the driver
- **ArgoCD**: Manages the continuous deployment of Kubernetes manifests
- **GitHub Webhooks**: Triggers the Jenkins pipeline upon git push events
- **Infrastructure**: Terraform configurations for provisioning AWS EC2 instances
- **Application**: Node.js application with Docker containerization

## Repository Structure

```
.
├── README.md
├── code/                  # Application source code
│   ├── Dockerfile        # Container image definition
│   ├── app.js           # Node.js application
│   ├── package.json     # Node.js dependencies
│   └── public/          # Static assets
├── infra/               # Infrastructure configurations
│   ├── Jenkinsfile      # Jenkins pipeline definition
│   └── manifests/       # Kubernetes manifests
└── terraform/           # Terraform configurations for AWS resources
```

## Architecture

1. **Source Control**:
   - Git Push triggers GitHub webhook
   - Repository contains application code, K8s manifests, and infrastructure as code

2. **CI/CD Pipeline**:
   - Jenkins fetches updated repository
   - Builds and tests application
   - Interacts with ArgoCD for deployment
   - Updates infrastructure using Terraform when needed

3. **Infrastructure**:
   - EC2 instances provisioned via Terraform
   - Minikube cluster running on EC2
   - ArgoCD syncs manifests with the cluster

4. **Deployment Flow**:
   - ArgoCD ensures cluster state matches repository configuration
   - Continuous monitoring and automatic sync of changes

## Prerequisites

### Tools Required
- Docker
- Minikube
- Jenkins
- ArgoCD CLI
- Git
- Terraform
- AWS CLI

### AWS Configuration
- AWS account with appropriate permissions
- AWS credentials configured locally
- EC2 key pair for instance access

## Setup Instructions

1. **Infrastructure Setup**:
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

2. **Minikube Configuration**:
   ```bash
   minikube start --driver=docker
   ```

3. **Jenkins Setup**:
   - Run Jenkins container
   - Configure GitHub webhook
   - Set up necessary credentials

4. **ArgoCD Installation**:
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```

5. **Application Deployment**:
   ```bash
   cd code
   docker build -t your-app:latest .
   ```

## Usage

1. Make changes to your application code or Kubernetes manifests
2. Commit and push changes to GitHub
3. Jenkins pipeline will automatically trigger
4. ArgoCD will sync the changes to the cluster

## Infrastructure Management

The Terraform configurations in the `terraform/` directory manage:
- EC2 instance provisioning
- Security group configuration
- Network settings
- Any additional AWS resources needed

## Monitoring and Maintenance

- Access ArgoCD UI for deployment status
- Monitor Jenkins pipeline executions
- Check EC2 instance health via AWS Console
- Review application logs through kubectl

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.