#!/bin/bash
set -e

# AGENDA:
# * Add the docker/bundle_install script for installing Bundler and executing "yarn install" and "bundle install" (WICHTIG/LEGACY)
# * Enable docker/bundle_install in docker/build-log (WICHTIG/LEGACY)
# * Removing docker/gem_install_bundler from docker/build-log (redundant)

echo '#################################################'
echo 'Unit 1 Chapter 5: Yarn Install and Bundle Install'
echo '#################################################'

mv mod-01-05-docker_bundle_install docker/bundle_install
chmod +x docker/bundle_install

ruby mod-01-05.rb

echo '-------------------'
echo 'BEGIN: yarn install'
echo '-------------------'
yarn install
echo '-----------------'
echo 'END: yarn install'
echo '-----------------'

echo '---------------------'
echo 'BEGIN: bundle install'
echo '---------------------'
bundle install
echo '-------------------'
echo 'END: bundle install'
echo '-------------------'

git add .
git commit -m 'Added docker/bundle_install'
