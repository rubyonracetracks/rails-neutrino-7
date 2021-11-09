#!/bin/bash
set -e

# AGENDA:
# * Add bin/brakeman and docker/brakeman

# NOTES:
# * Note that the gem is commented out in the Gemfile and is uncommented ONLY during the moment it is used.
# * This provides the benefits WITHOUT adding to the Gemfile.lock dependencies.
# * WICHTIG/LEGACY: If the Gemfile does not have brakeman, use a setup similar to Rails Neutrino.
# * WICHTIG/LEGACY: If the Gemfile does have brakeman, there is no need for the bin/brakeman script to edit the Gemfile.

echo '#############################'
echo 'UNIT 3: VULNERABILITY TESTING'
echo '#############################'

echo '##########################'
echo 'Unit 3 Chapter 1: Brakeman'
echo '##########################'

echo 'Adding docker/brakeman'
mv mod-03-01-docker_brakeman docker/brakeman
chmod +x docker/brakeman

echo 'Adding bin/brakeman'
mv mod-03-01-bin_brakeman bin/brakeman
chmod +x bin/brakeman

ruby mod-03-01.rb

git add .
git commit -m 'Added Brakeman'
