#!/bin/bash
set -e

rm -rf tmp
mkdir -p tmp

RAILS_VERSION='6'
MODE='v0'
echo 'N' > tmp/host_env.txt
echo 'N' > tmp/annotate.txt

DATE=`date -u +%Y%m%d-%H%M%S-%3N`
APP_NAME="rails$RAILS_VERSION$MODE-$DATE"
echo "$DATE" > tmp/time_stamp.txt
echo "$APP_NAME" > tmp/app_name.txt

echo 'Y' > tmp/unit00.txt
echo 'N' > tmp/unit01.txt
echo 'N' > tmp/unit02.txt
echo 'N' > tmp/unit03.txt
echo 'N' > tmp/unit04.txt
echo 'N' > tmp/unit05.txt
echo 'N' > tmp/unit06.txt

mkdir -p log
bash build-rails.sh 2>&1 | tee log/$APP_NAME.txt
