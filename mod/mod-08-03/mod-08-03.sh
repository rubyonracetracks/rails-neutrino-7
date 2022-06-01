#!/bin/bash
set -e

# Create the static page views

# AGENDA
# * Create integration tests for the static pages.
# * Create the home, about, and contact page views.
# * Add the email_munger gem.
# * Remove the original static pages and associated tests.

echo '#################'
echo 'Static Page Views'
echo '#################'

ruby mod-08-03.rb

# BEGIN: annotate
if [ "$ANNOTATE" = 'Y' ]
then
  bin/annotate
else
  echo 'Skipping the annotation process to save time'
fi
# END: annotate

git add .
git commit -m "Created static page views"
