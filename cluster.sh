#!/bin/bash

# Update and install dependencies
sudo apt-get update -y
sudo apt-get install -y curl

# Install Docker (required for k3d)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Add the current user to the docker group
sudo usermod -aG docker $USER

# Install k3d (Lightweight Kubernetes using Docker)
curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

# Create a Kubernetes cluster with 1 master node and 2 worker nodes
k3d cluster create mycluster --servers 1 --agents 2

# Configure kubectl (k3d automatically sets up kubeconfig)
k3d kubeconfig merge mycluster --kubeconfig-merge-default

# Verify cluster nodes
kubectl get nodes

echo "✅ Kubernetes cluster with 1 master and 2 worker nodes has been created successfully in GitHub Codespace."
echo "You can start using kubectl to interact with the cluster!"
