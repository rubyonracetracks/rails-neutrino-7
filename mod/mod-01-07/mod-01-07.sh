#!/bin/bash
set -e

# AGENDA:
# * Add the docker/server and docker/server-log scripts for running the Rails server (WICHTIG/LEGACY)

echo '##############################'
echo 'Unit 1 Chapter 7: Rails Server'
echo '##############################'

mv mod-01-07-docker_server docker/server
chmod +x docker/server

mv mod-01-07-docker_server_log docker/server-log
chmod +x docker/server-log

git add .
git commit -m 'Added docker/server and docker/server-log'
