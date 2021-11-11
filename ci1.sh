#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

# PART 1: BUILDING THE NEW APP

source definitions.sh

# Deleting Docker images and containers
# Leftover images and containers from previous builds
# lead to error messages.
set +e
delete_docker_container "$DOCKER_CONTAINER_1"
delete_docker_container "$DOCKER_CONTAINER_2"
delete_docker_image "$DOCKER_IMAGE_1"
delete_docker_image "$DOCKER_IMAGE_2"
set -e

# Creating the new app and building the Docker image $DOCKER_IMAGE_1
mkdir -p log
docker build -t $DOCKER_IMAGE_1 .
wait

# Creating the Docker container $DOCKER_CONTAINER_1 from the Docker image $DOCKER_IMAGE_1
echo '--------------------------------------------------------'
echo "docker create --name $DOCKER_CONTAINER_1 $DOCKER_IMAGE_1"
docker create --name $DOCKER_CONTAINER_1 $DOCKER_IMAGE_1
wait

# Copying files from the Docker container $DOCKER_CONTAINER_1 to the host system
for i in $(docker ps -a | grep $DOCKER_CONTAINER_1 | awk '{print $1}')
do
  echo '------------------------------------------------------'
  echo "docker cp $i:/home/winner/neutrino/$APP_NAME $DIR_MAIN"
  docker cp $i:/home/winner/neutrino/$APP_NAME $DIR_MAIN
  wait
done;
wait
