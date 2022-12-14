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

touch tmp/annotate.txt

touch tmp/unit00.txt
touch tmp/unit01.txt
touch tmp/unit02.txt
touch tmp/unit03.txt
touch tmp/unit04.txt
touch tmp/unit05.txt
touch tmp/unit06.txt
touch tmp/unit07.txt
touch tmp/unit08.txt

LOG_BUILD="log/main-$TIME_STAMP-build.txt"
LOG_TEST_SQLITE="log/main-$TIME_STAMP-test-sqlite.txt"
LOG_TEST_POSTGRES="log/main-$TIME_STAMP-test-postgres.txt"
bash main-build.sh 2>&1 | tee "$LOG_BUILD"
bash main-all.sh 'rails_app_sqlite' 2>&1 | tee "$LOG_TEST_SQLITE"
bash main-all.sh 'rails_app_postgres' 2>&1 | tee "$LOG_TEST_POSTGRES"

echo 'LOG FILES:'
echo "$LOG_BUILD"
echo "$LOG_TEST_SQLITE"
echo "$LOG_TEST_POSTGRES"
