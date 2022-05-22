#!/bin/bash
set -e

# Adding Annotate

# AGENDA
# * Add the annotate gem to the Gemfile
# * Add bin/annotate for using the annotate gem
# * Add docker/annotate for executing bin/annotate in Docker
# * Enable docker/annotate in docker/outline-short

echo '########'
echo 'Annotate'
echo '########'

ruby mod-07-02.rb

git add .
git commit -m "Added annotate to the app"
