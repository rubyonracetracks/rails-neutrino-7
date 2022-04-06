#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

APP_NAME_TEST=$1
wait
source definitions.sh

# Copying the initially built app
rm -rf "$APP_NAME_TEST"
cp -rp "$APP_NAME" "$APP_NAME_TEST"
wait

# Copy Dockerfile-template to Dockerfile
cp $APP_NAME_TEST/Dockerfile-template $APP_NAME_TEST/Dockerfile

# BEGIN: Get Ruby version
cp $APP_NAME_TEST/.ruby-version tmp/.ruby-version-process
sed -i.bak "s|ruby-||g" tmp/.ruby-version-process
rm tmp/.ruby-version-process.bak
RUBY_VERSION_HERE=`cat tmp/.ruby-version-process`
rm tmp/.ruby-version-process
# END: Get Ruby version

# Fill in the Ruby version in the Dockerfile
$APP_NAME_TEST/docker/replace_sif 'RUBY_VERSION' "$RUBY_VERSION_HERE" $APP_NAME_TEST/Dockerfile

# TESTING THE NEW APP
DOCKER_IMAGE_1="image1-$APP_NAME_TEST"
DOCKER_IMAGE_2="image2-$APP_NAME_TEST"
DOCKER_CONTAINER_1="container1-$APP_NAME_TEST"
set +e
delete_docker_image $DOCKER_IMAGE_1
delete_docker_image $DOCKER_IMAGE_2
delete_docker_container $DOCKER_CONTAINER_1
set -e

# Setting up the new app and building the Docker image $DOCKER_IMAGE_1
echo '------------------------------------------------------'
echo "cd $APP_NAME_TEST && docker build -t $DOCKER_IMAGE_1 ."
cd $APP_NAME_TEST && docker build -t $DOCKER_IMAGE_1 .
wait

# NOTE: Current directory is $APP_NAME, not $DIR_MAIN

# Creating the Docker container $DOCKER_CONTAINER_1 from the Docker image $DOCKER_IMAGE_1
echo '--------------------------------------------------------'
echo "docker create --name $DOCKER_CONTAINER_1 $DOCKER_IMAGE_1"
docker create --name $DOCKER_CONTAINER_1 $DOCKER_IMAGE_1
wait

for i in $(docker ps -a | grep $DOCKER_CONTAINER_1 | awk '{print $1}')
do
  # Copying the new app from the host system to the Docker container $DOCKER_CONTAINER_1
  echo '---------------------------------'
  echo "docker cp . $i:/home/winner/myapp"
  docker cp . $i:/home/winner/myapp
  wait

  # Copying the fix_permissions script from the host system to the Docker container $DOCKER_CONTAINER_1
  echo '---------------------------------------------------------'
  echo "docker cp $DIR_MAIN/fix_permissions $i:/home/winner/myapp"
  docker cp $DIR_MAIN/fix_permissions $i:/home/winner/myapp

  # Copying the test_app_internal script from the host system to the Docker container $DOCKER_CONTAINER_1
  echo '-----------------------------------------------------------'
  echo "docker cp $DIR_MAIN/test_app_internal $i:/home/winner/myapp"
  docker cp $DIR_MAIN/test_app_internal $i:/home/winner/myapp

  # Creating the Docker image $DOCKER_IMAGE_2 from the Docker container $DOCKER_CONTAINER_1
  echo '--------------------------------'
  echo "docker commit $i $DOCKER_IMAGE_2"
  docker commit $i $DOCKER_IMAGE_2
  wait
done;

# Testing the new app in $DOCKER_IMAGE_2
# Executing fix_permissions and test_app_internal within $DOCKER_IMAGE_2
echo '---------------------------------------------------------------------'
echo "docker run -u root $DOCKER_IMAGE_2 /home/winner/myapp/fix_permissions"
docker run -u root $DOCKER_IMAGE_2 /home/winner/myapp/fix_permissions
