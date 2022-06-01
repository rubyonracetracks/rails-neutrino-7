#!/bin/bash
set -e

# Add Bootstrap styling

# AGENDA
# * Add the bootstrap-sass gem to the Gemfile.
# * Add app/assets/stylesheets/custom.scss.

echo '#################'
echo 'Bootstrap Styling'
echo '#################'

ruby mod-08-04.rb

git add .
git commit -m "Added Bootstrap styling"
