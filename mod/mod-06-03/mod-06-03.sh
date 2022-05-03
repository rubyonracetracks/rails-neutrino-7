#!/bin/bash
set -e

# AGENDA
# * Adding the better_errors and binding_of_caller gems to the Gemfile

echo '################################'
echo 'Better Errors, Binding of Caller'
echo '################################'

ruby mod-06-03.rb

git add .
git commit -m "Added the better_errors and binding_of_caller gems"
