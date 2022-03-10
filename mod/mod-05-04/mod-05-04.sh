#!/bin/bash
set -e

# In this chapter, SimpleCov is added.

# AGENDA
# Add simplecov to the Gemfile
# Set up test/test_helper.rb for SimpleCov

echo '###########################'
echo 'Unit 5 Chapter 4: SimpleCov'
echo '###########################'

ruby mod-05-04.rb

git add .
git commit -m "Added SimpleCov"
