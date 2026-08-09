# EKS Infrastructure with Terraform

This repository contains the Terraform code used to provision and manage the AWS infrastructure required for an Amazon EKS (Elastic Kubernetes Service) cluster.

## Architecture

```text
                    AWS Cloud
                        |
                       VPC
                        |
          +-------------+-------------+
          |                           |
     Public Subnets              Private Subnets
          |                           |
     NAT Gateway                EKS Worker Nodes
          |                           |
     Internet Gateway                 |
                                      |
                                EKS Cluster
                                      |
                                Kubernetes Pods
```

## Technologies Used

* AWS EKS
* AWS VPC
* AWS IAM
* AWS EC2
* AWS NAT Gateway
* AWS Internet Gateway
* Terraform
* Kubernetes

## Infrastructure Created

Terraform provisions:

* VPC
* Public and private subnets
* Internet Gateway
* NAT Gateways
* Route tables
* Elastic IPs
* EKS cluster
* EKS IAM roles
* EKS managed node group
* Required IAM policies

## Project Structure

```text
eks-infrastructure-terraform/
│
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── vpc.tf
├── iam.tf
├── eks.tf
├── outputs.tf
└── README.md
```

## Prerequisites

Install and configure:

* AWS CLI
* Terraform
* kubectl

Configure AWS credentials:

```bash
aws configure
```

Verify the configuration:

```bash
aws sts get-caller-identity
```

## Deploy Infrastructure

Initialize Terraform:

```bash
terraform init
```

Format the Terraform files:

```bash
terraform fmt
```

Validate the configuration:

```bash
terraform validate
```

Review the infrastructure changes:

```bash
terraform plan
```

Create the infrastructure:

```bash
terraform apply
```

Enter:

```text
yes
```

when prompted.

## Connect to EKS

After the cluster is created:

```bash
aws eks update-kubeconfig \
  --region ap-south-1 \
  --name my-eks-cluster
```

Verify the cluster:

```bash
kubectl get nodes
```

Expected output:

```text
NAME                                             STATUS   ROLES
ip-10-0-11-xxx.ap-south-1.compute.internal      Ready    <none>
ip-10-0-12-xxx.ap-south-1.compute.internal      Ready    <none>
```

## Destroy Infrastructure

To remove the infrastructure:

```bash
terraform destroy
```

Review the resources that will be deleted and enter:

```text
yes
```

## Repository Responsibility

This repository is responsible only for **AWS infrastructure provisioning**.

Kubernetes application deployment is maintained separately in the:

**`kubernetes-gitops-argocd`** repository.

## Future Enhancements

* Remote Terraform state using S3
* Terraform state locking
* EKS access management
* AWS Load Balancer Controller
* Karpenter for node autoscaling
* CloudWatch monitoring
* EKS cluster logging
* Terraform CI/CD
