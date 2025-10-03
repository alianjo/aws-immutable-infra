# AWS Immutable Infrastructure

A demonstration of DevOps best practices using Infrastructure as Code (IaC), immutable deployments, and automated CI/CD pipelines on AWS.

This project builds a Packer AMI with nginx and a sample app, deploys it via Terraform into an Auto Scaling Group behind an Application Load Balancer (ALB), and automates the process using GitHub Actions.

---

## Overview

* **Packer** builds immutable AMIs with nginx and app files
* **Terraform** provisions VPC, ALB, Launch Template, and Auto Scaling Group
* **GitHub Actions** automates AMI build and Terraform deployment
* **ALB + ASG** provide high availability and zero-downtime deployments

---

## Architecture

```mermaid
graph LR
    A[GitHub Actions] --> B[Packer AMI Build]
    B --> C[Terraform Apply]
    C --> D[Auto Scaling Group]
    D --> E[EC2 Instances (AMI)]
    E --> F[Application Load Balancer]
    F --> G[User Traffic]
```

---

## Quick Start

1. Clone the repository:

```bash
git clone https://github.com/yourusername/aws-immutable-infra.git
cd aws-immutable-infra
```

2. Build the AMI:

```bash
cd packer
packer init .
packer validate .
packer build .
```

3. Deploy the infrastructure:

```bash
cd ../terraform
terraform init
terraform apply
```

4. Get the application URL:

```bash
terraform output website_url
```

---

## Project Structure

```
aws-immutable-infra/
├── packer/       # Packer templates (AMI build)
├── terraform/    # Terraform IaC (VPC, ALB, ASG)
├── app/          # Sample app (served via nginx)
├── userdata/     # EC2 bootstrap scripts
└── .github/      # GitHub Actions CI/CD
```

---

## Purpose

* Demonstrates immutable infrastructure pattern
* Shows Infrastructure as Code with Terraform and Packer
* Implements zero-downtime deployments with ASG and ALB
* Highlights CI/CD automation with GitHub Actions
