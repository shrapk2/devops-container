FROM fedora:37

RUN dnf install -y jq wget curl unzip \
    ## Hashicorp Terraform
    && export TERRAFORM_VERS=$(curl https://api.github.com/repos/hashicorp/terraform/releases/latest | jq --raw-output '.tag_name' | cut -c 2-) \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERS}/terraform_${TERRAFORM_VERS}_linux_amd64.zip \
    && unzip terraform*.zip \
    && mv terraform /usr/bin/ \
    && rm -f terraform*.zip \
    ## Hashicorp Vault \
    && export VAULT_VERS=$(curl https://api.github.com/repos/hashicorp/vault/releases/latest | jq --raw-output '.tag_name' | cut -c 2-) \
    && wget https://releases.hashicorp.com/vault/${VAULT_VERS}/vault_${VAULT_VERS}_linux_amd64.zip \
    && unzip vault*.zip \
    && mv vault /usr/bin/ \
    && rm -f vault*.zip \
    #Gruntworks Terragrunt
    && export TERRAGRUNT_VERS=$(curl https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | jq --raw-output '.tag_name' | cut -c 2-) \
    && wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERS}/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/bin/terragrunt \
    ## Ensure we can execute the binaries
    && chmod +x /usr/bin/terra* /usr/bin/vault \
    && dnf update -y \
    && dnf upgrade -y \
    && dnf install -y vim podman ansible awscli python3-botocore python3-boto3 rsync git nano \
    # Kubernetes CLI
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/bin/kubectl \
    # Docker CLI
    && ln -s $(which podman) /usr/bin/docker