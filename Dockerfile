FROM fedora:33
MAINTAINER shrapk2
#ENV TERRAFORM_VERS='0.14.3'
#ENV VAULT_VERS='1.6.1'
#ENV TERRAGRUNT_VERS='0.26.7'
RUN dnf install -y ansible jq nano awscli wget curl unzip git python3-botocore python3-boto3 rsync \
    ## Azure
    && rpm --import https://packages.microsoft.com/keys/microsoft.asc \
    && echo $'[azure-cli] \n\
name=Azure CLI \n\
baseurl=https://packages.microsoft.com/yumrepos/azure-cli \n\
enabled=1 \n\
gpgcheck=1 \n\
gpgkey=https://packages.microsoft.com/keys/microsoft.asc' > /etc/yum.repos.d/azure-cli.repo \
    && cat /etc/yum.repos.d/azure-cli.repo \
    && yum install -y azure-cli \
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
    && dnf install -y vim
