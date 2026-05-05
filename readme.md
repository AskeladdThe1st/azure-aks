Azure AKS GitOps Platform

This project demonstrates a production-grade, automated infrastructure and application deployment pipeline using Microsoft Azure, Terraform, and GitHub Actions. It is designed with a focus on modularity, security, and high operational stability.  
## Architecture Overview

The platform is built on three core pillars to ensure a scalable and secure environment:  

    Infrastructure as Code (IaC): Modular Terraform configuration used to provision a Virtual Network (VNet), Managed Identities, and an Azure Kubernetes Service (AKS) cluster.  

    Containerized Application: A lightweight, high-availability web service packaged with Docker.  

    Automated CI/CD: A GitHub Actions pipeline that automates infrastructure updates, container image builds, and Kubernetes deployments.  

## Project Structure

The repository follows a professional directory layout to separate concerns and improve maintainability:  

    /terraform: Contains the root configuration and provider settings.  

        /modules: Isolated components for vnet, identity, and aks to ensure code reusability.  

    /src: Application source code and the Dockerfile for containerization.  

    /k8s: Kubernetes manifests (deployment.yaml, service.yaml) defining the desired state of the application.  

    /.github/workflows: Automation scripts for the end-to-end CI/CD process.  

## Key Features
### 1. Operational Stability & Self-Healing

    Health Probes: Implemented liveness and readiness probes in the Kubernetes deployment to ensure AKS automatically restarts failing containers and manages traffic during rollouts.  

    Resource Management: Explicit CPU and memory limits are defined to prevent resource contention and optimize cluster performance.  

### 2. Security First

    Managed Identities: Utilizes Azure-native identities for secure communication between AKS and the Azure Container Registry (ACR), eliminating the need for hard-coded credentials.  

    Network Isolation: All resources are provisioned within a private Virtual Network (VNet) to minimize the public attack surface.  

### 3. Automated CI/CD Workflow

    Continuous Integration: GitHub Actions automatically builds the Docker image and pushes it to ACR upon every code change.  

    Continuous Deployment: The pipeline triggers a rolling update to the AKS cluster, ensuring zero-downtime deployments.  

## Getting Started

    Infrastructure: Initialize and apply the Terraform configuration to provision the Azure resources.  
    Bash

    cd terraform
    terraform init
    terraform apply

    Deployment: Push changes to the main branch to trigger the GitHub Action.  

    Verification: Access the application via the Public IP provided by the Azure LoadBalancer service.  

## Technical Stack

    Cloud: Microsoft Azure  

    IaC: Terraform  

    Orchestration: Kubernetes (AKS)  

    CI/CD: GitHub Actions  

    Containers: Docker