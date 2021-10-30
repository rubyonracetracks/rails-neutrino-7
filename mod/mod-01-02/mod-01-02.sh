#!/bin/bash
set -e

# AGENDA:
# * Add the docker/nuke and docker/nukec scripts (WICHTIG/LEGACY)

echo '#######################################'
echo 'Unit 1 Chapter 2: Docker Nuking Scripts'
echo '########################################'

mkdir -p docker
mv mod-01-02-docker_nukec docker/nukec
chmod +x docker/nukec
mv mod-01-02-docker_nuke docker/nuke
chmod +x docker/nuke

git add .
git commit -m 'Added docker/nuke and docker/nukec'
