#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

DIR_MAIN=$PWD

RAILS_VERSION=`cat tmp/rails_version.txt`
MODE=`cat tmp/mode.txt`
STAGE=`cat tmp/stage.txt`
APP_NAME=`cat tmp/app_name.txt`
DIR_APP=$DIR_MAIN/$APP_NAME
TIME_STAMP=`cat tmp/time_stamp.txt`

DOCKER_IMAGE_1=`cat tmp/docker_image_1.txt`
DOCKER_IMAGE_2=`cat tmp/docker_image_2.txt`
DOCKER_IMAGE_3=`cat tmp/docker_image_3.txt`
DOCKER_CONTAINER_1=`cat tmp/docker_container_1.txt`
DOCKER_CONTAINER_2=`cat tmp/docker_container_2.txt`

ANNOTATE=`cat tmp/annotate.txt`
CONFIG_DOCKERFILE=`cat tmp/config_dockerfile.txt`

UNIT_00=`cat tmp/unit00.txt`
UNIT_01=`cat tmp/unit01.txt`
UNIT_02=`cat tmp/unit02.txt`
UNIT_03=`cat tmp/unit03.txt`
UNIT_04=`cat tmp/unit04.txt`
UNIT_05=`cat tmp/unit05.txt`
UNIT_06=`cat tmp/unit06.txt`

# Delete Docker containers
delete_docker_container () {
  CONTAINER=$1
  echo "Deleting Docker container $CONTAINER"
  for i in $(docker ps -a | grep $CONTAINER | awk '{print $1}')
  do
    docker kill $i; wait;
    docker rm -f $i; wait;
  done;
}

# Delete Docker images
delete_docker_image () {
  IMAGE=$1
  echo 'Deleting dangling Docker images'
  docker image prune -f

  echo "Deleting Docker image $IMAGE"
  for i in $(docker images -a | grep $IMAGE | awk '{print $1}')
  do
    docker kill $i; wait;
    docker rmi -f $i; wait;
  done;
}
