# RedHat Developer Hub Quick Start

## Introduction 

This repository helps developers to run the RedHat Developer Hub locally and integrates with Gitea for OAuth.

## Start up locally

**Step 1:**

Clone `auth-config.yaml.template` to `auth-config.yaml` under the `dev-hub` folder. 

**Step 2:**

Update the `auth.providers` section of the YAML with the `clientId` and `clientSecret` for either GitHub or GitLab.

**Step 3:**

Configure the `signInPage`. It should be either GitHub or GitLab.

**Step 4:**

Bring up the Developer Hub:

```bash
podman compose up

## Configuring plugins

Update `start_dev_hub.sh` file with necessary endpoints for other tools like Jira/SonarQube. Currently, random values are being set.
