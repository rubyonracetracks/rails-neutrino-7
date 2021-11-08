#!/bin/bash
set -e

# AGENDA
# * Add Rails Best Practices to the Gemfile (WICHTIG/LEGACY: if necessary)
# * Add docker/rbp (WICHTIG/LEGACY: if necessary)
# * Update docker/test_code (WICHTIG/LEGACY: if necessary)
# * Update docker/git_check (WICHTIG/LEGACY: if necessary)
# * Generate the initial config/rails_best_practices.yml. (WICHTIG/LEGACY: if necessary)

echo '######################################'
echo 'Unit 2 Chapter 4: Rails Best Practices'
echo '######################################'

mv mod-02-04-docker_rbp docker/rbp
chmod +x docker/rbp

ruby mod-02-04.rb

# Generates the Rails Best Practices configuration file at config/rails_best_practices.yml
bundle exec rails_best_practices -g

git add .
git commit -m 'Added Rails_Best Practices'
