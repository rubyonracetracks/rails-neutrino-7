#!/bin/bash
set -e

# AGENDA:
# * Add the docker/sandbox script for running the Rails sandbox environment (WICHTIG/LEGACY)

echo '###############################'
echo 'Unit 1 Chapter 8: Rails Sandbox'
echo '###############################'

mv mod-01-08-docker_sandbox docker/sandbox
chmod +x docker/sandbox

git add .
git commit -m 'Added docker/sandbox'
