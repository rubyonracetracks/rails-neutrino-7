#!/bin/bash
set -e

echo '+++++++++++++++++++++++++++'
echo 'BEGIN: docker-compose build'
echo '+++++++++++++++++++++++++++'
docker-compose build
echo '+++++++++++++++++++++++++'
echo 'END: docker-compose build'
echo '+++++++++++++++++++++++++'

echo '#################################################'
echo 'BEGIN: docker-compose run web bash build-rails.sh'
echo '#################################################'
docker-compose run web bash build-rails.sh
echo '###############################################'
echo 'END: docker-compose run web bash build-rails.sh'
echo '###############################################'
echo '#######'
echo 'NEW APP'
echo 'BEGIN: docker/build'
echo '###################'

APP_NAME=`cat tmp/app_name.txt`
cd $APP_NAME && docker/build
echo '#######'
echo 'NEW APP'
echo 'END: docker/build'
echo '#################'

echo '**********************************'
echo 'Your new Rails app has been built!'
echo 'Path:'
echo "$PWD/$APP_NAME"
echo ''
echo ''
echo 'Log file:'
echo "$PWD/log/$APP_NAME.txt"
