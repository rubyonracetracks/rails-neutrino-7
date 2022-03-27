#!/bin/bash
set -e

# AGENDA
# * sqlite3 should be limited to the development and test environments.
# * pg should be specified for the production environment

# NOTES
# * In the Gemfile, the pg gem MUST be specified for the production environment.
# * In the Gemfile, the sqlite3 gem must NOT be specified for the production environment. 
#   (You may use it in the development and testing environments.)

echo '####################'
echo 'Updating the Gemfile'
echo '####################'

ruby mod-04-01.rb

git add .
git commit -m "Updated the Gemfile (pg for production environment)"
