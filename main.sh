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
APP_NAME="rails$RAILS_VERSION$MODE$STAGE-$TIME_STAMP"

rm -rf $APP_NAME

echo "$MODE" > tmp/mode.txt
echo "$STAGE" > tmp/stage.txt
echo "$APP_NAME" > tmp/app_name.txt
echo "$TIME_STAMP" > tmp/time_stamp.txt

echo 'Y' > tmp/annotate.txt
echo 'N' > tmp/config_dockerfile.txt

echo 'Y' > tmp/unit00.txt
echo 'Y' > tmp/unit01.txt
echo 'Y' > tmp/unit02.txt
echo 'Y' > tmp/unit03.txt
echo 'Y' > tmp/unit04.txt
echo 'Y' > tmp/unit05.txt
echo 'Y' > tmp/unit06.txt

LOG_BUILD="log/main-$TIME_STAMP-build.txt"
LOG_TEST_SQLITE="log/main-$TIME_STAMP-test.txt"
bash main-build.sh 2>&1 | tee log/main-$TIME_STAMP-build.txt
bash main-test.sh 'rails_app_sqlite' 2>&1 | tee log/main-$TIME_STAMP-test.txt

echo 'LOG FILES:'
echo "$LOG_BUILD"
echo "$LOG_TEST_SQLITE"
