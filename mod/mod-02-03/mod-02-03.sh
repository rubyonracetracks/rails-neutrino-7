#!/bin/bash
set -e

# AGENDA:
# * Fix the RuboCop offenses not covered by autocorrect

echo '###########################################'
echo 'Unit 2 Chapter 3: Other RuboCop Corrections'
echo '###########################################'

echo 'Adding .rubocop.yml'
mv mod-02-03-rubocop_yml.txt .rubocop.yml
bundle exec rake db:migrate # Updates db/schema.rb

git add .
git commit -m 'Other RuboCop corrections'
