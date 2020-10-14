FROM fedora:latest
MAINTAINER shrapk2
ENV TERRAFORM_VERS='0.13.4'
ENV VAULT_VERS='1.5.4'
ENV TERRAGRUNT_VERS='0.25.3'
RUN dnf install -y ansible awscli wget curl unzip git python3-botocore python3-boto3 rsync \
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
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERS}/terraform_${TERRAFORM_VERS}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERS}_linux_amd64.zip \
    && mv terraform /usr/bin/ \
    && rm -f terraform_${TERRAFORM_VERS}_linux_amd64.zip \
    ## Hashicorp Vault \
    && wget https://releases.hashicorp.com/vault/${VAULT_VERS}/vault_${VAULT_VERS}_linux_arm64.zip \
    && unzip vault_${VAULT_VERS}_linux_arm64.zip \
    && mv vault /usr/bin/ \
    && rm -f vault_${VAULT_VERS}_linux_arm64.zip \
    #Gruntworks Terragrunt
    && wget https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERS}/terragrunt_linux_amd64 \
    && mv terragrunt_linux_amd64 /usr/bin/terragrunt \
    ## Ensure we can execute the binaries
    && chmod +x /usr/bin/terra* /usr/bin/vault
