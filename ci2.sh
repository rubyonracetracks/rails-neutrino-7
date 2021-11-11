#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

source definitions.sh

# PART 2: TESTING THE NEW APP

# Setting up the new app and building the Docker image $DOCKER_IMAGE_2
echo '-------------------------------------------------'
echo "cd $APP_NAME && docker build -t $DOCKER_IMAGE_2 ."
cd $APP_NAME && docker build -t $DOCKER_IMAGE_2 .
wait

# NOTE: Current directory is $APP_NAME, not $DIR_MAIN

# Creating the Docker container $DOCKER_CONTAINER_2 from the Docker image $DOCKER_IMAGE_2
echo '--------------------------------------------------------'
echo "docker create --name $DOCKER_CONTAINER_2 $DOCKER_IMAGE_2"
docker create --name $DOCKER_CONTAINER_2 $DOCKER_IMAGE_2
wait

for i in $(docker ps -a | grep $DOCKER_CONTAINER_2 | awk '{print $1}')
do
  # Copying the new app from the host system to the Docker container $DOCKER_CONTAINER_2
  echo '---------------------------------'
  echo "docker cp . $i:/home/winner/myapp"
  docker cp . $i:/home/winner/myapp
  wait

  # Copying the fix_permissions script from the host system to the Docker container $DOCKER_CONTAINER_2
  echo '---------------------------------------------------------'
  echo "docker cp $DIR_MAIN/fix_permissions $i:/home/winner/myapp"
  docker cp $DIR_MAIN/fix_permissions $i:/home/winner/myapp

  # Copying the test_app_internal script from the host system to the Docker container $DOCKER_CONTAINER_2
  echo '-----------------------------------------------------------'
  echo "docker cp $DIR_MAIN/test_app_internal $i:/home/winner/myapp"
  docker cp $DIR_MAIN/test_app_internal $i:/home/winner/myapp

  # Creating the Docker image $DOCKER_IMAGE_3 from the Docker container $DOCKER_CONTAINER_2
  echo '--------------------------------'
  echo "docker commit $i $DOCKER_IMAGE_3"
  docker commit $i $DOCKER_IMAGE_3
  wait
done;

# Testing the new app in $DOCKER_IMAGE_3
# Executing fix_permissions and test_app_internal within $DOCKER_IMAGE_3
echo '---------------------------------------------------------------------'
echo "docker run -u root $DOCKER_IMAGE_3 /home/winner/myapp/fix_permissions"
docker run -u root $DOCKER_IMAGE_3 /home/winner/myapp/fix_permissions
