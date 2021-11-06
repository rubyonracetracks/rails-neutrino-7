#!/bin/bash
set -e

# AGENDA:
# * Add RuboCop
# * Add docker/cop script (WICHTIG/LEGACY: if necessary)
# * Add docker/test_code script (WICHTIG/LEGACY)
# * Enable docker/test_code in docker/build-log (WICHTIG/LEGACY)
# * Enable docker/cop in docker/test_code (WICHTIG/LEGACY: if necessary)
# * Enable docker/cop in docker/git_check (WICHTIG/LEGACY: if necessary)
# * WICHTIG/LEGACY: If the app does not already include RuboCop, do not add it.

echo '############'
echo 'UNIT 2: LINT'
echo '############'

echo '################################'
echo 'Unit 2 Chapter 1: Adding RuboCop'
echo '################################'

echo 'Adding docker/cop'
mv mod-02-01-docker_cop docker/cop
chmod +x docker/cop

echo 'Adding docker/test_code'
mv mod-02-01-docker_test_code docker/test_code
chmod +x docker/test_code

ruby mod-02-01.rb

git add .
git commit -m 'Added RuboCop'
