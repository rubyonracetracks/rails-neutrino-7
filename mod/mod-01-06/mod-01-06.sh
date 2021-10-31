#!/bin/bash
set -e

# AGENDA:
# * Add the docker/migrate script for database migration (WICHTIG/LEGACY)
# * Enable docker/migrate in docker/build-log (WICHTIG/LEGACY)

echo '####################################'
echo 'Unit 1 Chapter 6: Database Migration'
echo '####################################'

mv mod-01-06-docker_migrate docker/migrate
chmod +x docker/migrate

ruby mod-01-06.rb

echo '---------------------------'
echo 'bundle exec rake db:migrate'
echo '---------------------------'
bundle exec rake db:migrate

git add .
git commit -m 'Added docker/migrate'
