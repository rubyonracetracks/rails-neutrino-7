#!/bin/bash
set -e

# AGENDA:
# * Add docker/bundle_outdated (WICHTIG/LEGACY)
# * Enable docker/bundle_outdated in docker/test_code (WICHTIG/LEGACY)

# NOTES:
# * "bundle outdated" replaces Gemsurance.
# * Gemsurance works for me in version 1 of Bundler but not in version 2.

echo '#################################'
echo 'Unit 3 Chapter 3: bundle outdated'
echo '#################################'

echo 'Adding docker/bundle_outdated'
mv mod-03-03-docker-bundle_outdated docker/bundle_outdated
chmod +x docker/bundle_outdated

ruby mod-03-03.rb

git add .
git commit -m 'Added docker/bundle_outdated'
