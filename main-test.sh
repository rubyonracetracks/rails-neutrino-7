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

# PART 2: TESTING THE NEW APP
DIR_APP_TEST_FULL=$DIR_MAIN/$DIR_APP_TEST
if [[ "$DIR_APP_TEST" =~ 'postgres' ]]
then
  cd "$DIR_APP_TEST_FULL" && docker/pg_setup_2 'rails_app' 'jbond007' 'BondJamesBond'
fi
cd "$DIR_APP_TEST_FULL" && docker/build
