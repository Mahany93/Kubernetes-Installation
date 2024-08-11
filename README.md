<<<<<<< HEAD
# **Deploy Zammad - Help Desk and Ticket System on K8s Cluster**
>This was tested on Rocky Linux v9.4 .
||||||| a961bd8 (Change the Code to only deploy K8s)
# **Deploy Kubernetes on Ubuntu Linux Using Bash Scripts
>This was tested on Ubuntu 24.04 LTS .
=======
# **Deploy Zammad - Help Desk and Ticket System on K8s Cluster**
>This was tested on Ubuntu 24.04 LTS .
>>>>>>> parent of a961bd8 (Change the Code to only deploy K8s)

<<<<<<< HEAD
## Deploy Zammad using bash scripts.
First we need to run the script "rename-server.sh" to rename the linux server and add localhost entry to /etc/hosts
||||||| a961bd8 (Change the Code to only deploy K8s)
### Prerequisites.
> - Two Ubuntu 24.04 VMs with static IP addresses for Kubernetes Master and worker nodes. In my scenario I named them ***"k8s-m01.home.local"*** for the Master and ***"k8s-w01.home.local"*** for the Worker node.

## Deployment steps.
First we need to run the script "rename-server.sh" to rename both ubuntu servers and add localhost entry to /etc/hosts\
>Note: This step will be applied on both ***"k8s-m01.home.local"*** and ***"k8s-w01.home.local"***
=======
### Prerequisites.
> - Two Ubuntu 24.04 VMs with static IP addresses for Kubernetes Master and worker nodes. In my scenario I named them ***"k8s-m01.home.local"*** for the Master and ***"k8s-w01.home.local"*** for the Worker node.

## Deploy Zammad using bash scripts.
First we need to run the script "rename-server.sh" to rename both ubuntu servers and add localhost entry to /etc/hosts\
>Note: This step will be applied on both ***"k8s-m01.home.local"*** and ***"k8s-w01.home.local"***
>>>>>>> parent of a961bd8 (Change the Code to only deploy K8s)

```
1. mkdir /zammadSource && cd /zammadSource
2. Save the script to a file, e.g., rename-server.sh.
3. Make the script executable:
    chmod +x rename-server.sh
4. Run the script with the new hostname as an argument:
    sudo ./rename-server.sh <new_fqdn>
    Replace <new_fqdn> with the desired hostname and domain name for your server.
5. Restart the server with "reboot" command to apply the new hostname. 
```

Then we have to run the script "install-microK8s.sh" to install snapd, microK8s and apply new SELinux settings.
```
1. Save the script to a file, e.g., install-microK8s.sh.
2. Make the script executable:
    chmod +x install-microK8s.sh
3. Run the script:
    sudo ./install-microK8s.sh
4. Restart the server with "reboot" command.
5. Run the below commands to confirm that Microk8s is working as expected.
    microk8s status
    microk8s kubectl get nodes
```
===========================================================================

<<<<<<< HEAD
The below steps will configure the K8s cluster and deploy zammad using manual method. 
## Rename the server and update /etc/hosts file
||||||| a961bd8 (Change the Code to only deploy K8s)
This next step will initialize the Master node and get it to working state.
>Note: This step will be applied only on ***"k8s-m01.home.local"*** .
```
1. Copy the script "master-initialization.sh" to the directory /zammadSource.
2. Make the script executable:
    chmod +x master-initialization.sh.sh
3. Run the script:
    sudo ./master-initialization.sh
4. Run the below commands to confirm that K8s is working as expected.
    kubectl get pods --all-namespaces -o wide
    kubectl cluster-info
```

This step will join the worker node to the cluster.\
The previous "master-initialization.sh" script that we did run on the Master node exported an output file "**/var/join-worker.txt**". This file contains the command we need to join any subsequent worked nodes to the cluster. The command format will be "***kubeadm join \<master-ip>:\<master-port> --token <token>***"
> Note: This step will be applied on  ***"k8s-w01.home.local"***
```
1. Open SSH console on the worker node "k8s-w01.home.local" and run the command we explained above to join it to the K8s cluster.
    "***\<master-ip>:\<master-port> --token <token>***"
2. Make the script executable:
    chmod +x master-initialization.sh.sh
3. Run the script:
    sudo ./master-initialization.sh
4. Run the below command on the Master node to confirm that the new worker node has become ready and running after a while.
    kubectl get nodes -o wide
=======
This next step will initialize the Master node and get it to working state.
>Note: This step will be applied only on ***"k8s-m01.home.local"*** .
```
1. Copy the script "master-initialization.sh" to the directory /zammadSource.
2. Make the script executable:
    chmod +x master-initialization.sh.sh
3. Run the script:
    sudo ./master-initialization.sh
4. Run the below commands to confirm that K8s is working as expected.
    kubectl get pods --all-namespaces -o wide
    kubectl cluster-info
```

The last step here is to join the worker node to the cluster.\
The previous "master-initialization.sh" script that we did run on the Master node exported an output file "**/var/join-worker.txt**". This file contains the command we need to join any subsequent worked nodes to the cluster. The command format will be "***kubeadm join \<master-ip>:\<master-port> --token <token>***"
> Note: This step will be applied on  ***"k8s-w01.home.local"***
```
1. Open SSH console on the worker node "k8s-w01.home.local" and run the command we explained above to join it to the K8s cluster.
    "***\<master-ip>:\<master-port> --token <token>***"
2. Make the script executable:
    chmod +x master-initialization.sh.sh
3. Run the script:
    sudo ./master-initialization.sh
4. Run the below command on the Master node to confirm that the new worker node has become ready and running after a while.
    kubectl get nodes -o wide
>>>>>>> parent of a961bd8 (Change the Code to only deploy K8s)

```
1. Rename the server to zammad01
    hostnamectl set-hostname zammad01
    echo "zammad01" > /etc/hostname
3. Update /etc/hosts
    sed -i "s/127\.0\.1\.1.*/127.0.1.1 zammad01/" /etc/hosts
4. Restart the server with "reboot" command to apply the new hostname. 
```
---
## Install Snapd
Microk8s is a snap package and so snapd is required on the Rocky Linux 9 system.
The below commands can be used to install snapd on Rocky Linux 9.
```
1.  Enable the EPEL repository.
    sudo dnf install -y epel-release

2.  Install snapd.
    sudo dnf install -y snapd

3.  create a symbolic link for classic snap support.
    sudo ln -s /var/lib/snapd/snap /snap

4.  Export the snaps $PATH.
    echo 'export PATH=$PATH:/var/lib/snapd/snap/bin' | sudo tee -a /etc/profile.d/snap.sh
    source /etc/profile.d/snap.sh

5.  Start and enable the service.
    sudo systemctl enable --now snapd.socket

6.  Set SELinux in permissive mode.
    sudo setenforce 0
    sudo sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config
```
---

## Install Microk8s
```
1.  Install Microk8s package.
    sudo snap install -y microk8s --classic 

2.  Set the below permissions.
    sudo usermod -a -G microk8s $USER
    sudo chown -f -R $USER ~/.kube

3.  Apply the changes.
    newgrp microk8s
    microk8s status

4.  Get the available nodes.
    microk8s kubectl get nodes
```
