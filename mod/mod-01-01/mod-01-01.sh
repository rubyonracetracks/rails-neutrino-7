#!/bin/bash
set -e

# AGENDA:
# * Removing instances of .DS_Store (WICHTIG/LEGACY)
# * Updating .gitignore to prevent accidental additions of .DS_Store
#   and other irrelevant files and to mark the initial contents (WICHTIG/LEGACY)
# * Updating the Gemfile to mark the initial contents
# * NOTE: config/time_stamp.txt was added prior to the
#   execution of this script.

echo '#########'
echo 'GITIGNORE'
echo '#########'

ruby mod-01-01.rb

git add .
git commit -m 'Updated .gitignore'
