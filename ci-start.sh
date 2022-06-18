#!/bin/bash
set -e

mkdir -p log
rm -rf tmp
mkdir -p tmp

DIR_MAIN=$PWD
RAILS_VERSION=`cat params/rails_version.txt`
MODE='H'
STAGE='m'
TIME_STAMP=`date -u +%Y%m%d-%H%M%S`
APP_NAME='rails_neutrino_app'

rm -rf $APP_NAME

echo "$MODE" > tmp/mode.txt
echo "$STAGE" > tmp/stage.txt
echo "$APP_NAME" > tmp/app_name.txt
echo "$TIME_STAMP" > tmp/time_stamp.txt

touch tmp/unit00.txt
touch tmp/unit01.txt
touch tmp/unit02.txt
touch tmp/unit03.txt
touch tmp/unit04.txt
touch tmp/unit05.txt
touch tmp/unit06.txt
touch tmp/unit07.txt
touch tmp/unit08.txt
touch tmp/unit09.txt
