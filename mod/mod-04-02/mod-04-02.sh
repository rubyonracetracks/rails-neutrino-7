#!/bin/bash
set -e

# AGENDA
# * Create a barrier to destroying data with rake commands in the
#   product environment by creating the script
#   lib/tasks/disable_db_tasks_on_production.rake

# This is a safeguard to prevent disasters.

echo '###########################################################'
echo 'Unit 4 Chapter 2: Restricting Dangerous Tasks in Production'
echo '###########################################################'

# WICHTIG/LEGACY/production: restrict dangerous tasks in production (if necessary)
mv mod-04-02-disable.rake lib/tasks/disable_db_tasks_on_production.rake

git add .
git commit -m "Restrict dangerous tasks in production"
