#!/bin/bash
set -e

# Adding docker/tree

# AGENDA
# * Add bin/tree for printing out the file structure of the app
# * Add docker/tree for executing bin/tree in Docker
# * Add docker/outline and docker/outline-short
# * Enable docker/outline-short in docker/git_check
# * Enable docker/outline in docker/build-log

echo '############'
echo 'Tree Scripts'
echo '############'

# WICHTIG/LEGACY/bash: add bin/tree
echo 'Adding bin/tree'
mv mod-07-01-bin-tree bin/tree
chmod +x bin/tree

# WICHTIG/LEGACY/bash: add docker/tree
echo 'Adding docker/tree'
mv mod-07-01-docker-tree docker/tree
chmod +x docker/tree

# WICHTIG/LEGACY/bash: add docker/outline
echo 'Adding docker/outline'
mv mod-07-01-docker-outline docker/outline
chmod +x docker/outline

# WICHTIG/LEGACY/bash: add docker/outline-short
echo 'Adding docker/outline-short'
mv mod-07-01-docker-outline-short docker/outline-short
chmod +x docker/outline-short

ruby mod-07-01.rb

git add .
git commit -m "Added docker/tree and outline scripts; enabled outline scripts in docker/build and docker/git_check"
