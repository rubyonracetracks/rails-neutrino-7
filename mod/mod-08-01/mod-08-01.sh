#!/bin/bash
set -e

# Set up the title helper

# AGENDA
# * Add test/helpers/application_helper_test.rb
# * Add app/helpers/application_helper.rb

# NOTE: At the end of this chapter, Rails Best Practices flags the title
# helper as an unused method.  This will be resolved in a later chapter.

echo '############'
echo 'Title Helper'
echo '############'

ruby mod-08-01.rb

# BEGIN: annotate
if [ "$ANNOTATE" = 'Y' ]
then
  bin/annotate
else
  echo 'Skipping the annotation process to save time'
fi
# END: annotate

git add .
git commit -m "Added title helper"
