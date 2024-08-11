#!/bin/bash

# initialize the Kubernetes cluster configuration on the master node.
    echo "Instructions to join worker nodes has been saved in file /var/join-worker.txt"
    sudo kubeadm init --pod-network-cidr=10.244.0.0/16 > /var/join-worker.txt
    mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Flannel Pod Network
    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/master/deploy/local-path-storage.yaml
    kubectl patch storageclass <storage-class-name> -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
    kubectl get pods -n local-path-storage
    kubectl get nodes