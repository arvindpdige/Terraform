# Terraform

# Create Harness Docker Delegate with Terraform to be installed

Dockerfile:
```
FROM us-docker.pkg.dev/gar-prod-setup/harness-public/harness/delegate:25.08.86600

USER root

# Only install unzip (curl-minimal is already there)
RUN microdnf install -y unzip \
 && curl -fsSL https://releases.hashicorp.com/terraform/1.13.3/terraform_1.13.3_linux_amd64.zip -o /tmp/terraform.zip \
 && unzip /tmp/terraform.zip -d /usr/local/bin \
 && rm /tmp/terraform.zip \
 && terraform --version

USER harness

```

docker build -t arvindpdige/harness-delegate-terraform:1.13.3 .
docker push arvindpdige/harness-delegate-terraform:1.13.3

docker run -d --cpus=1 --memory=2g \
  -e DELEGATE_NAME=docker-delegate \
  -e NEXT_GEN="true" \
  -e DELEGATE_TYPE="DOCKER" \
  -e ACCOUNT_ID="..." \
  -e DELEGATE_TOKEN="..." \
  -e DELEGATE_TAGS="terraform" \
  -e MANAGER_HOST_AND_PORT=https://app.harness.io \
  arvindpdige/harness-delegate-terraform:1.13.3

