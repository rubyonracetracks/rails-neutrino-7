#!/bin/bash
set -e

RAILS_VERSION=`cat params/rails_version.txt`
MODE='V'
STAGE='8'
APP_NAME="rails$RAILS_VERSION$MODE$STAGE"
TIME_STAMP=`date -u +%Y%m%d-%H%M%S-%3N`

rm -rf tmp
mkdir -p tmp

rm -rf $APP_NAME

echo "$MODE" > tmp/mode.txt
echo "$STAGE" > tmp/stage.txt
echo "$APP_NAME" > tmp/app_name.txt
echo "$TIME_STAMP" > tmp/time_stamp.txt

touch tmp/unit08.txt

mkdir -p log
bash build-rails.sh 2>&1 | tee log/$APP_NAME-$TIME_STAMP.txt
