#!/bin/bash
set -e

# AGENDA:
# * Add the docker/build and other scripts needed to build the Docker container and execute commands in it (WICHTIG/LEGACY)
# * Add the Dockerfile to .gitignore (WICHTIG/LEGACY: except in legacy projects that are already Dockerized)

echo '######################################'
echo 'Unit 1 Chapter 3: Docker Build Scripts'
echo '######################################'

mv mod-01-03-Dockerfile-template Dockerfile-template
mv mod-01-03-docker-compose.yml docker-compose.yml
mv mod-01-03-docker_build docker/build
chmod +x docker/build
mv mod-01-03-docker_build-log docker/build-log
chmod +x docker/build-log
mv mod-01-03-docker_run docker/run
chmod +x docker/run
mv mod-01-03-docker_replace_sif docker/replace_sif
chmod +x docker/replace_sif
echo '' >> .gitignore
echo 'Dockerfile' >> .gitignore
echo '' >> .gitignore

# Get the Node version
NODE_V1=`node -v`
NODE_V2=`echo "$NODE_V1" | tr -d 'v'`

# Fill in the Node version in Dockerfile-template
docker/replace_sif 'NODE_VERSION_HERE' "$NODE_V2" Dockerfile-template

git add .
git commit -m 'Added the docker/build and other scripts needed to build the Docker container and execute commands in it'
