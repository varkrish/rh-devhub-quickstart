# RedHat Developer Hub Quick Start
## Introduction 

This repo helps devs to run the RH developer hub locally and integrates with Gitea for OAuth.

## Start up locally

`
podman compose up
`
This command brings up Gitea, RH Dev Hub and Initializer container to wire up Gitea and RH Dev Hub.

## Starting again from scratch

`
./clean_and_start.sh
`

This cleans all the podman containers and associated volumes to start the install from scratch. 

## TODO

Full Oauth setup, plugin configuration and verification