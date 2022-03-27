#!/bin/bash
set -e

# Set up Minitest Reporters to provide red/green displays, a list of the
# most time-consuming tests within your test suite, and commands for
# repeating the tests that failed.

# AGENDA
# * Add minitest and minitest-reporters to the Gemfile
# * Add test/rake_rerun_reporter.rb
# * Update test/test_helper.rb to run Minitest
# * Update .gitignore
# * Added first integration test and public/index.html

echo '##################'
echo 'Minitest Reporters'
echo '##################'

ruby mod-05-01.rb

git add .
git commit -m "Set up Minitest Reporters"
