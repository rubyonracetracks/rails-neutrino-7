#!/bin/bash
set -e

# AGENDA
# * Add user model parameters.
# * Add user model tests.
# * Edit the user model to get the tests to pass.
# * Add the faker and ruby-progressbar gems to the Gemfile

echo '######################'
echo 'Adding User Parameters'
echo '######################'

ruby mod-09-03.rb

# BEGIN: annotate
if [ "$ANNOTATE" = 'Y' ]
then
  bin/annotate
else
  echo 'Skipping the annotation process to save time'
fi
# END: annotate

git add .
git commit -m "Added user parameters"

