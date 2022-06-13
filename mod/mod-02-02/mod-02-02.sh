#!/bin/bash
set -e

# AGENDA:
# * Add docker/cop-auto (WICHTIG/LEGACY: if necessary)
# * Use RuboCop's Autocorrect

echo '###################'
echo 'RuboCop Autocorrect'
echo '###################'

echo 'Adding docker/cop-auto'
mv mod-02-02-docker-cop-auto docker/cop-auto
chmod +x docker/cop-auto

git add .
git commit -m 'Added docker/cop-auto'

echo 'Using RuboCop Autocorrect'
set +e
bundle exec rubocop --autocorrect-all
set -e
bundle exec rake db:migrate # Updates db/schema.rb

git add .
git commit -m 'Used RuboCop Autocorrect'
