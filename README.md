# **Deploy Zammad - Help Desk and Ticket System on K8s Cluster**
>This was tested on Ubuntu 24.04 LTS .

### Prerequisites.
> - Two Ubuntu 24.04 VMs with static IP addresses for Kubernetes Master and worker nodes. In my scenario I named them ***"k8s-m01.home.local"*** for the Master and ***"k8s-w01.home.local"*** for the Worker node.

## Deploy Zammad using bash scripts.
First we need to run the script "rename-server.sh" to rename both ubuntu servers and add localhost entry to /etc/hosts\
>Note: This step will be applied on both ***"k8s-m01.home.local"*** and ***"k8s-w01.home.local"***

```
1. mkdir /zammadSource && cd /zammadSource
2. Copy the script "rename-server.sh" to the directory /zammadSource.
3. Make the script executable:
    chmod +x rename-server.sh
4. Run the script with the new hostname as an argument:
    sudo ./rename-server.sh <new_fqdn>
    Replace <new_fqdn> with the desired hostname and domain name for your server.
5. Restart the server with "reboot" command to apply the new hostname. 
```

Then we have to run the script "install-K8s.sh" to install K8s packages and dependencies on both Master and Worker node VMs.
>Note: This step will be applied on both ***"k8s-m01.home.local"*** and ***"k8s-w01.home.local"***
```
1. Copy the script "install-K8s.sh" to the directory /zammadSource.
2. Make the script executable:
    chmod +x install-K8s.sh
3. Run the script:
    sudo ./install-K8s.sh
```

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

```
