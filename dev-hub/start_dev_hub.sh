#!/bin/bash

# Function to generate random UUID
generate_random_uuid() {
  uuidgen
}

# Function to generate random FQDN
generate_fqdn() {
  echo "gitea"
}

# Function to export random environment variables
export_random_env_variables() {
  # GitHub
  export GITHUB_ORG=$(generate_random_uuid)
  
  # GitLab
  export GITLAB_HOST="http://localhost:3000/"
  export GITLAB_TOKEN=$(head -1 /usr/src/app/packages/app-config/.accesstoken)

  # Kubernetes
  export K8S_CLUSTER_NAME=$(generate_random_uuid)
  export K8S_CLUSTER_URL=$(generate_random_uuid)
  export K8S_CLUSTER_TOKEN=$(generate_random_uuid)

    # Azure DevOps
    export AZURE_TOKEN=$(generate_random_uuid)
    export AZURE_ORG="your_azure_org"

  # ArgoCD
  export ARGOCD_USERNAME=$(generate_random_uuid)
  export ARGOCD_PASSWORD=$(generate_random_uuid)
  export ARGOCD_INSTANCE1_URL=$(generate_fqdn)
  export ARGOCD_AUTH_TOKEN=$(generate_random_uuid)
  export ARGOCD_INSTANCE2_URL=$(generate_fqdn)
  export ARGOCD_AUTH_TOKEN2=$(generate_random_uuid)

  # Azure DevOps
  export AZURE_TOKEN=$(generate_random_uuid)
  export AZURE_ORG=$(generate_random_uuid)

  # Jenkins
  export JENKINS_URL=$(generate_fqdn)
  export JENKINS_USERNAME=$(generate_random_uuid)
  export JENKINS_TOKEN=$(generate_random_uuid)

  # SonarQube
  export SONARQUBE_URL=$(generate_fqdn)
  export SONARQUBE_TOKEN=$(generate_random_uuid)

  # OCM
  export OCM_HUB_NAME=$(generate_random_uuid)
  export OCM_HUB_URL=$(generate_fqdn)
  export MOC_INFRA_TOKEN=$(generate_random_uuid)

  # TechDocs
  export TECHDOCS_BUILDER_TYPE=$(generate_random_uuid)
  export TECHDOCS_GENERATOR_TYPE=$(generate_random_uuid)
  export TECHDOCS_PUBLISHER_TYPE=$(generate_random_uuid)
  export BUCKET_NAME=$(generate_random_uuid)
  export BUCKET_REGION_VAULT=$(generate_random_uuid)
  export BUCKET_URL=$(generate_random_uuid)
  export AWS_ACCESS_KEY_ID=$(generate_random_uuid)
  export AWS_SECRET_ACCESS_KEY=$(generate_random_uuid)

  # ArgoCD (continued)
  export ARGOCD_USERNAME=$(generate_random_uuid)
  export ARGOCD_PASSWORD=$(generate_random_uuid)
  export ARGOCD_INSTANCE1_URL=$(generate_fqdn)
  export ARGOCD_AUTH_TOKEN=$(generate_random_uuid)
  export ARGOCD_INSTANCE2_URL=$(generate_fqdn)
  export ARGOCD_AUTH_TOKEN2=$(generate_random_uuid)

  # Additional variables
  export SEGMENT_WRITE_KEY=$(generate_random_uuid)
  export SEGMENT_MASK_IP=$(generate_random_uuid)
  export SEGMENT_TEST_MODE=$(generate_random_uuid)
  export DYNATRACE_URL="dyna.localhost"

 }

# Run the node command with the generated environment variables
export_random_env_variables
node packages/backend \
  --config /usr/src/app/packages/app-config/app-config.yaml \
  --config /usr/src/app/packages/app-config/dynamic-plugins.default.yaml \
  --config /usr/src/app/packages/app-config/app-config.dynamic-plugins.yaml \
  --config /usr/src/app/packages/app-config/auth-config.yaml 