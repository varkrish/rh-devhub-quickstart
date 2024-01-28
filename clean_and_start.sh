#!/bin/bash
# Stop and remove containers defined in the docker-compose.yml
podman-compose down
# Remove the individual containers
podman rm -f gitea
podman rm -f developer-hub
podman rm -f gitea-initializer
# Remove volumes associated with the containers
podman volume rm gitea-data
podman volume rm backstage-data
rm ./dev-hub/.accesstoken
rm ./dev-hub/auth-config.yaml
rm ./dev-hub/.*json*
podman compose up
