#!/bin/bash
set -e

# This chapter adds Capybara.

# AGENDA
# Add capybara-email and capybara-slow_finder_errors to the Gemfile
# Set up test/test_helper.rb for Capybara
# Add additional integration tests and make them pass

echo '##########################'
echo 'Unit 5 Chapter 3: Capybara'
echo '##########################'

ruby mod-05-03.rb

git add .
git commit -m "Added Capybara"

