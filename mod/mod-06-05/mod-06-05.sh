#!/bin/bash
set -e

# Adding a script that updates the gems with "bundle update"

# AGENDA
# * Add docker/upgrade for upgrading outdated Yarn and Ruby packages
echo '##############'
echo 'Upgrade Script'
echo '##############'

# WICHTIG/LEGACY/bash: add docker/upgrade
mv mod-06-05-docker_upgrade docker/upgrade
chmod +x docker/upgrade

git add .
git commit -m "Added docker/upgrade"
