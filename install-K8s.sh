#!/bin/bash

# Update and Upgrade the System.
    sudo apt update && sudo apt upgrade -y

# Install Docker.
    sudo sudo apt install -y docker.io
    sudo apt install containerd -y
    sudo systemctl start containerd
    sudo systemctl enable containerd
    DockerVersion=$(sudo docker --version)
    echo "$DockerVersion" has been installed

# Install Kubernetes Components.
    echo "Installing Kubernetes Components"
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    sudo apt update
    sudo apt install -y kubelet kubeadm kubectl
    # The below command freeze the packages at their current version to avoid automatic updates. This is crucial for maintaining the stability and compatibility of the Kubernetes cluster.
    sudo apt-mark hold kubelet kubeadm kubectl

# Disable Swap.
    sudo swapoff -a
    sudo sed -i '/swap/s/^/#/' /etc/fstab

# Enable IP forwarding.
    sudo sysctl -w net.ipv4.ip_forward=1
    echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p
