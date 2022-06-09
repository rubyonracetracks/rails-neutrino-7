#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

DIR_APP_TEST=$1
wait
source definitions.sh
rm -rf "$DIR_APP_TEST"
cp -rp "$APP_NAME" "$DIR_APP_TEST"
wait

DIR_APP_TEST_FULL="$DIR_MAIN/$DIR_APP_TEST"

# PART 2: TESTING THE NEW APP
DIR_APP_TEST_FULL=$DIR_MAIN/$DIR_APP_TEST
if [[ "$DIR_APP_TEST_FULL" =~ 'postgres' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/pg_setup_2 'rails_app' 'jbond007' 'BondJamesBond'
fi
cd "$DIR_APP_TEST_FULL" && docker/create_dockerfile
cd "$DIR_APP_TEST_FULL" && docker/compose_up
cd "$DIR_APP_TEST_FULL" && docker/bundle_install
if [[ "$DIR_APP_TEST_FULL" =~ 'postgres' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/db_setup
fi
cd "$DIR_APP_TEST_FULL" && docker/migrate

if [[ "$DIR_APP_TEST_FULL" =~ 'test' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/test
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'server' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker-compose up -d
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'rbp' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/rbp
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'rubocop' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/cop
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'audit' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/audit
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'brakeman' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/brakeman
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'outdated' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/bundle_outdated
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'tree' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/tree
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'annotate' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/annotate
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'railroady' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/railroady
fi

if [[ "$DIR_APP_TEST_FULL" =~ 'erd' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/rails-erd
fi
