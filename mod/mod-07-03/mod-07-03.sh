#!/bin/bash
set -e

# Adding block diagram gems

# AGENDA
# * Add the railroady and rails-erd gems to the Gemfile
# * Add bin/replace_sif for replacing the string in a file
# * Add bin/railroady for using the railroady gem
# * Add bin/rails-erd for using the rails-erd gem
# * Add docker/outline-long for executing bin/railroady and bin/rails-erd in Docker
# * Enable docker/outline-long in docker/build-log

echo '##################'
echo 'Block Diagram Gems'
echo '##################'

ruby mod-07-03.rb

git add .
git commit -m "Added block diagram gems"
