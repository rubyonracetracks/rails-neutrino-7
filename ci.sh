#!/bin/bash
set -e

RAILS_VERSION='6'
MODE='H'
STAGE='ci'
APP_NAME="rails$RAILS_VERSION$MODE$STAGE"
TIME_STAMP=`date -u +%Y%m%d-%H%M%S-%3N`
DOCKER_IMAGE="image-rails_neutrino_$RAILS_VERSION"
DOCKER_CONTAINER="container-rails_neutrino_$RAILS_VERSION"

rm -rf tmp
mkdir -p tmp

rm -rf $APP_NAME

echo "$RAILS_VERSION" > tmp/rails_version.txt
echo "$MODE" > tmp/mode.txt
echo "$STAGE" > tmp/stage.txt
echo "$APP_NAME" > tmp/app_name.txt
echo "$TIME_STAMP" > tmp/time_stamp.txt

echo 'N' > tmp/annotate.txt

echo 'Y' > tmp/unit00.txt
echo 'Y' > tmp/unit01.txt
echo 'Y' > tmp/unit02.txt
echo 'Y' > tmp/unit03.txt
echo 'Y' > tmp/unit04.txt
echo 'Y' > tmp/unit05.txt
echo 'Y' > tmp/unit06.txt

bash nukec.sh
mkdir -p log
docker build -t $DOCKER_IMAGE . 2>&1 | tee log/$APP_NAME-$TIME_STAMP-part1.txt
wait
docker create --name $DOCKER_CONTAINER $DOCKER_IMAGE
wait
docker cp $DOCKER_CONTAINER:/home/winner/neutrino/$APP_NAME $PWD
wait
cd $APP_NAME && docker/build | tee log/$APP_NAME-$TIME_STAMP-part2.txt
