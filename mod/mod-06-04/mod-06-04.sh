#!/bin/bash
set -e

# Adding the pry-rails gem to improve the screen output in the console environment

# When you enter "User.all" or "Admin.all", the screen output will be much
# more readable.

# AGENDA
# * Adding the pry-rails gem to the Gemfile.

echo '#########'
echo 'pry-rails'
echo '#########'

ruby mod-06-04.rb

git add .
git commit -m "Added pry-rails gem"

