<<<<<<< HEAD
#!/bin/bash

# Reference "https://github.com/zammad/zammad-helm/blob/main/zammad/README.md"

microk8s helm repo add zammad https://zammad.github.io/zammad-helm
microk8s helm upgrade --install zammad zammad/zammad
||||||| a961bd8 (Change the Code to only deploy K8s)
=======
#!/bin/bash

# Reference "https://github.com/zammad/zammad-helm/blob/main/zammad/README.md"

# Install Helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh

# Install Zammad from Helm Chart
    helm repo add zammad https://zammad.github.io/zammad-helm
    helm upgrade --install zammad zammad/zammad
>>>>>>> parent of a961bd8 (Change the Code to only deploy K8s)
