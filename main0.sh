#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

DIR_MAIN=$PWD
RAILS_VERSION='6'
MODE='H'
STAGE='m'
APP_NAME="rails$RAILS_VERSION$MODE$STAGE"
TIME_STAMP=`date -u +%Y%m%d-%H%M%S-%3N`
DOCKER_IMAGE_1="image1-rails_neutrino_$RAILS_VERSION"
DOCKER_CONTAINER_1="container1-rails_neutrino_$RAILS_VERSION"
DOCKER_IMAGE_2="image2-rails_neutrino_$RAILS_VERSION"
DOCKER_CONTAINER_2="container2-rails_neutrino_$RAILS_VERSION"
DOCKER_IMAGE_3="image3-rails_neutrino_$RAILS_VERSION"

mkdir -p log
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
echo "$DOCKER_IMAGE_3" > tmp/docker_image_3.txt
echo "$DOCKER_CONTAINER_1" > tmp/docker_container_1.txt
echo "$DOCKER_CONTAINER_2" > tmp/docker_container_2.txt

echo 'Y' > tmp/annotate.txt
echo 'N' > tmp/config_dockerfile.txt

echo 'Y' > tmp/unit00.txt
echo 'Y' > tmp/unit01.txt
echo 'Y' > tmp/unit02.txt
echo 'Y' > tmp/unit03.txt
echo 'Y' > tmp/unit04.txt
echo 'Y' > tmp/unit05.txt
echo 'Y' > tmp/unit06.txt
