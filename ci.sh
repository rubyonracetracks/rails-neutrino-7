#!/bin/bash
set -e

RAILS_VERSION='6'
MODE='H'
STAGE='ci'
APP_NAME="rails$RAILS_VERSION$MODE$STAGE"
TIME_STAMP=`date -u +%Y%m%d-%H%M%S-%3N`
DOCKER_IMAGE_1="image1-rails_neutrino_$RAILS_VERSION"
DOCKER_CONTAINER_1="container1-rails_neutrino_$RAILS_VERSION"
DOCKER_IMAGE_2="image2-rails_neutrino_$RAILS_VERSION"
DOCKER_CONTAINER_2="container2-rails_neutrino_$RAILS_VERSION"
DOCKER_IMAGE_3="image3-rails_neutrino_$RAILS_VERSION"
DIR_MAIN=$PWD

rm -rf tmp
mkdir -p tmp

rm -rf $APP_NAME

echo "$RAILS_VERSION" > tmp/rails_version.txt
echo "$MODE" > tmp/mode.txt
echo "$STAGE" > tmp/stage.txt
echo "$APP_NAME" > tmp/app_name.txt
echo "$TIME_STAMP" > tmp/time_stamp.txt

echo "$DOCKER_IMAGE_1" > tmp/docker_image_1.txt
echo "$DOCKER_IMAGE_2" > tmp/docker_image_2.txt
echo "$DOCKER_CONTAINER_1" > tmp/docker_container_1.txt
echo "$DOCKER_CONTAINER_2" > tmp/docker_container_2.txt

echo 'N' > tmp/annotate.txt
echo 'Y' > tmp/config_dockerfile.txt

echo 'Y' > tmp/unit00.txt
echo 'Y' > tmp/unit01.txt
echo 'Y' > tmp/unit02.txt
echo 'Y' > tmp/unit03.txt
echo 'Y' > tmp/unit04.txt
echo 'Y' > tmp/unit05.txt
echo 'Y' > tmp/unit06.txt

# Remove Docker containers and images
delete_docker_container () {
  CONTAINER=$1
  echo "Deleting Docker container $CONTAINER"
  for i in $(docker ps -a | grep $CONTAINER | awk '{print $1}')
  do
    docker kill $i; wait;
    docker rm -f $i; wait;
  done;
}

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

# Deleting Docker images and containers
# Leftover images and containers from previous builds
# lead to error messages.
set +e
delete_docker_container "$DOCKER_CONTAINER_1"
delete_docker_container "$DOCKER_CONTAINER_2"
delete_docker_image "$DOCKER_IMAGE_1"
delete_docker_image "$DOCKER_IMAGE_2"
set -e

# Part 1: creating the new app and building the Docker image $DOCKER_IMAGE_1
mkdir -p log
docker build -t $DOCKER_IMAGE_1 . 2>&1 | tee log/$APP_NAME-$TIME_STAMP-part1.txt
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

# Part 2: setting up the new app and building the Docker image $DOCKER_IMAGE_2
build_rails_app () {
  echo '-------------------------------------------------'
  echo "cd $APP_NAME && docker build -t $DOCKER_IMAGE_2 ."
  cd $APP_NAME && docker build -t $DOCKER_IMAGE_2 .
}
build_rails_app 2>&1 | tee $DIR_MAIN/log/$APP_NAME-$TIME_STAMP-part2.txt
wait

# Creating the Docker container $DOCKER_CONTAINER_2 from the Docker image $DOCKER_IMAGE_2
echo '--------------------------------------------------------'
echo "docker create --name $DOCKER_CONTAINER_2 $DOCKER_IMAGE_2"
docker create --name $DOCKER_CONTAINER_2 $DOCKER_IMAGE_2

for i in $(docker ps -a | grep $DOCKER_CONTAINER_2 | awk '{print $1}')
do
  # Copying the new app from the host system to the Docker container $DOCKER_CONTAINER_2
  echo '-------------------------------------------'
  echo "docker cp . $i:/home/winner/myapp/$APP_NAME"
  docker cp . $i:/home/winner/myapp
  wait

  # Creating the Docker image $DOCKER_IMAGE_3 from the Docker container $DOCKER_CONTAINER_2
  echo '--------------------------------'
  echo "docker commit $i $DOCKER_IMAGE_3"
  docker commit $i $DOCKER_IMAGE_3
done;

# Part 3: testing the new app in $DOCKER_IMAGE_3
# Executing test_app_internal.sh within $DOCKER_IMAGE_3
test_rails_app () {
  echo '---------------------------------------------------------------------'
  echo "docker run -u root $DOCKER_IMAGE_3 /home/winner/myapp/fix_permissions"
  docker run -u root $DOCKER_IMAGE_3 /home/winner/myapp/fix_permissions
}
test_rails_app 2>&1 | tee $DIR_MAIN/log/$APP_NAME-$TIME_STAMP-part3.txt
