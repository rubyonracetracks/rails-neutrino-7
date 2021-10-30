#!/bin/bash
set -e

# AGENDA:
# * Add the docker/gem_install_bundler script for installing the correct version of Bundler (WICHTIG/LEGACY)
# * Enable docker/gem_install_bundler in docker/build-log (WICHTIG/LEGACY)

echo '#############################################'
echo 'Unit 1 Chapter 4: Bundler Installation Script'
echo '#############################################'

mv mod-01-04-docker_gem_install_bundler docker/gem_install_bundler
chmod +x docker/gem_install_bundler

ruby mod-01-04.rb

# Install the correct version of Bundler for the Rails Neutrino setup
BUNDLER_VERSION=`awk '/BUNDLED WITH/{getline;print;}' Gemfile.lock`
echo '---------------------------------------'
echo "gem install bundler -v $BUNDLER_VERSION"

git add .
git commit -m 'Added docker/gem_install_bundler'
