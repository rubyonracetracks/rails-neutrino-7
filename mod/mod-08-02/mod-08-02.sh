#!/bin/bash
set -e

# Create the static pages

# AGENDA
# * Add the static pages controller for the home, about, and contact pages.
# * Add the static pages controller tests.
# * Fill in the static pages controller so that the tests pass.

# NOTE: Rails Best Practices still flags the title helper as an unused method.
# This will be resolved in a later chapter.

echo '######################'
echo 'Static Page Controller'
echo '######################'

ruby mod-08-02.rb

# BEGIN: annotate
if [ "$ANNOTATE" = 'Y' ]
then
  bin/annotate
else
  echo 'Skipping the annotation process to save time'
fi
# END: annotate

git add .
git commit -m "Added static pages controller"
