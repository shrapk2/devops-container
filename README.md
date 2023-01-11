# devops-container

Just a basic Fedora-based Docker image for facilitating automation containing: `ansible`, `terraform`, `vault`, `kubectl`, `aws`, and `terragrunt`.

Published on Docker Hub: `docker pull shrapk2/devops`

Uses the `latest` tag of the projects for Terraform, Vault, and Terragrunt.  It should be running the latest stable of all the tools.

Current base Fedora version: `fedora:37`

Happy automating.


## How To

- At the very basic, this will allow you to enter into the container and do the things

    ```bash
    docker run -dit --name awesomedev1 shrapk2/devops:latest /bin/bash
    docker exec -it awesomedev1 /bin/bash
    ```

## Future Enhancements
