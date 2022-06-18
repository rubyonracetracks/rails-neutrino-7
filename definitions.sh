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

UNIT_00='N'
if [ -f tmp/unit00.txt ]; then
  UNIT_00='Y'
fi

UNIT_01='N'
if [ -f tmp/unit01.txt ]; then
  UNIT_01='Y'
fi

UNIT_02='N'
if [ -f tmp/unit02.txt ]; then
  UNIT_02='Y'
fi

UNIT_03='N'
if [ -f tmp/unit03.txt ]; then
  UNIT_03='Y'
fi

UNIT_04='N'
if [ -f tmp/unit04.txt ]; then
  UNIT_04='Y'
fi

UNIT_05='N'
if [ -f tmp/unit05.txt ]; then
  UNIT_05='Y'
fi

UNIT_06='N'
if [ -f tmp/unit06.txt ]; then
  UNIT_06='Y'
fi

UNIT_07='N'
if [ -f tmp/unit07.txt ]; then
  UNIT_07='Y'
fi

UNIT_08='N'
if [ -f tmp/unit08.txt ]; then
  UNIT_08='Y'
fi

UNIT_09='N'
if [ -f tmp/unit09.txt ]; then
  UNIT_09='Y'
fi

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
