#!/bin/bash
set -e

DIR_MAIN=$PWD

DOCKER_IMAGE_1=`cat tmp/docker_image_1.txt`
DOCKER_IMAGE_2=`cat tmp/docker_image_2.txt`
DOCKER_CONTAINER_1=`cat tmp/docker_container_1.txt`
DOCKER_CONTAINER_1=`cat tmp/docker_container_2.txt`

echo '--------------------------------------------------------'
echo "docker create --name $DOCKER_CONTAINER_1 $DOCKER_IMAGE_1"
docker create --name $DOCKER_CONTAINER_1 $DOCKER_IMAGE_1
wait
for i in $(docker ps -a | grep $DOCKER_CONTAINER_1 | awk '{print $1}')
do
  echo $i
  echo '------------------------------------------------------'
  echo "docker cp $i:/home/winner/neutrino/$APP_NAME $DIR_MAIN"
  docker cp $i:/home/winner/neutrino/$APP_NAME $DIR_MAIN
  wait
done;
