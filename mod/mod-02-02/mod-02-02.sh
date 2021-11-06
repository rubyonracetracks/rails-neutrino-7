#!/bin/bash
set -e

# AGENDA:
# * Add docker/cop-auto (WICHTIG/LEGACY: if necessary)
# * Use RuboCop's Autocorrect

echo '#####################################'
echo 'Unit 2 Chapter 2: RuboCop Autocorrect'
echo '#####################################'

echo 'Adding docker/cop-auto'
mv mod-02-02-docker-cop-auto docker/cop-auto
chmod +x docker/cop-auto

git add .
git commit -m 'Added docker/cop-auto'

echo 'Using RuboCop Autocorrect'
bundle exec rubocop --auto-correct-all
bundle exec rake db:migrate # Updates db/schema.rb

git add .
git commit -m 'Used RuboCop Autocorrect'
