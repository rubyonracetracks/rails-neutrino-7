#!/bin/bash
set -e

RAILS_VERSION='6'
MODE='V'
STAGE='1'
APP_NAME="rails$RAILS_VERSION$MODE$STAGE"
TIME_STAMP=`date -u +%Y%m%d-%H%M%S-%3N`

rm -rf tmp
mkdir -p tmp

rm -rf $APP_NAME

echo "$RAILS_VERSION" > tmp/rails_version.txt
echo "$MODE" > tmp/mode.txt
echo "$STAGE" > tmp/stage.txt
echo "$APP_NAME" > tmp/app_name.txt
echo "$TIME_STAMP" > tmp/time_stamp.txt

echo 'N' > tmp/annotate.txt

echo 'N' > tmp/unit00.txt
echo 'Y' > tmp/unit01.txt
echo 'N' > tmp/unit02.txt
echo 'N' > tmp/unit03.txt
echo 'N' > tmp/unit04.txt
echo 'N' > tmp/unit05.txt
echo 'N' > tmp/unit06.txt

mkdir -p log
bash build-rails.sh 2>&1 | tee log/$APP_NAME-$TIME_STAMP.txt