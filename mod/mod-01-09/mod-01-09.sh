#!/bin/bash
set -e

# AGENDA:
# * Add the docker/test and docker/test-log scripts for running the test suite (WICHTIG/LEGACY)
# * Add the rexml to the Gemfile (necessary in Ruby 3)
# * Activate the testing process in docker/build-log (WICHTIG/LEGACY)
# * Add the docker/git_check script to run before executing "git add" and "git commit" (WICHTIG/LEGACY)

echo '####################'
echo 'Initial Test Scripts'
echo '####################'

mv mod-01-09-docker_test docker/test
chmod +x docker/test

mv mod-01-09-docker_test_log docker/test-log
chmod +x docker/test-log

mv mod-01-09-docker_git_check docker/git_check
chmod +x docker/git_check

ruby mod-01-09.rb

git add .
git commit -m 'Added docker/test and docker/test-log'
