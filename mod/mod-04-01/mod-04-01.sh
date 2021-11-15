#!/bin/bash
set -e

# AGENDA
# * sqlite3 should be limited to the development and test environments.
# * pg should be specified for the production environment

# NOTES
# * In the Gemfile, the pg gem MUST be specified for the production environment.
# * In the Gemfile, the sqlite3 gem must NOT be specified for the production environment. 
#   (You may use it in the development and testing environments.)

echo '##############################'
echo 'UNIT 4: PRODUCTION ENVIRONMENT'
echo '##############################'

echo '######################################'
echo 'Unit 4 Chapter 1: Updating the Gemfile'
echo '######################################'

git checkout -b 04-01-update_gemfile

ruby mod-04-01.rb

git add .
git commit -m "Updated the Gemfile (pg for production environment)"
git checkout master
git merge 02-01-update_gemfile
