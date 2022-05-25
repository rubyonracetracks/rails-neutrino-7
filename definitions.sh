#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -eo pipefail

DIR_MAIN=$PWD

RAILS_VERSION=`cat params/rails_version.txt`
MODE=`cat tmp/mode.txt`
STAGE=`cat tmp/stage.txt`
APP_NAME=`cat tmp/app_name.txt`
TIME_STAMP=`cat tmp/time_stamp.txt`
DIR_APP=$DIR_MAIN/$APP_NAME

ANNOTATE='N'
if [ -f tmp/annotate.txt ]; then
  ANNOTATE='Y'
fi

UNIT_00=`cat tmp/unit00.txt`
UNIT_01=`cat tmp/unit01.txt`
UNIT_02=`cat tmp/unit02.txt`
UNIT_03=`cat tmp/unit03.txt`
UNIT_04=`cat tmp/unit04.txt`
UNIT_05=`cat tmp/unit05.txt`
UNIT_06=`cat tmp/unit06.txt`
UNIT_07=`cat tmp/unit07.txt`

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
