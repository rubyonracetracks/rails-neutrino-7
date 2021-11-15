#!/bin/bash

# NOTE: set -o pipefail is needed to ensure that any error or failure causes the whole pipeline to fail.
# Without this specification, the CI status will provide a false sense of security by showing builds
# as succeeding in spite of errors or failures.
set -euo pipefail

bash main0.sh
source definitions.sh
bash main1.sh 2>&1 | tee log/$APP_NAME-$TIME_STAMP-part1.txt
bash main2.sh 2>&1 | tee log/$APP_NAME-$TIME_STAMP-part2.txt