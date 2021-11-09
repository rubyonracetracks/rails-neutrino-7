#!/bin/bash
set -e

# AGENDA:
# * Add bin/audit and docker/audit
# * Enable docker/brakeman in docker/test_code

# NOTES:
# * Note that the gem is commented out in the Gemfile and is uncommented ONLY during the moment it is used.
# * This provides the benefits WITHOUT adding to the Gemfile.lock dependencies.
# * WICHTIG/LEGACY: If the Gemfile does not have bundler-audit, use a setup similar to Rails Neutrino.
# * WICHTIG/LEGACY: If the Gemfile does have bundler-audit, there is no need for the bin/brakeman script to edit the Gemfile.

echo '###############################'
echo 'Unit 3 Chapter 2: bundler-audit'
echo '###############################'

echo 'Adding docker/audit'
mv mod-03-02-docker_audit docker/audit
chmod +x docker/audit

echo 'Adding bin/audit'
mv mod-03-02-bin_audit bin/audit
chmod +x bin/audit

ruby mod-03-02.rb

git add .
git commit -m 'Added bundler-audit'
