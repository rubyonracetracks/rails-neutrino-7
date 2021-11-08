#!/bin/bash
set -e

# AGENDA
# * Add bin/sandi_meter and docker/sandi_meter

echo '#############################'
echo 'Unit 2 Chapter 5: Sandi Meter'
echo '#############################'

mv mod-02-05-bin-sandi_meter bin/sandi_meter
chmod +x bin/sandi_meter

mv mod-02-05-docker_sandi_meter docker/sandi_meter
chmod +x docker/sandi_meter

ruby mod-02-05.rb

git add .
git commit -m 'Added Sandi Meter'
