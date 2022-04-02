#!/bin/bash

set -e

mkdir -p log

TIME_STAMP=`date -u +%Y%m%d-%H%M%S`
LOG_BUILD="log/ci-$TIME_STAMP-build.txt"
LOG_TEST_SQLITE="log/ci-$TIME_STAMP-test.txt"
bash ci-build.sh 2>&1 | tee "$LOG_BUILD"
bash ci-test.sh 'rails_neutrino_test_sqlite' 2>&1 | tee "$LOG_TEST_SQLITE"

echo 'LOG FILES:'
echo "$LOG_BUILD"
echo "$LOG_TEST_SQLITE"
