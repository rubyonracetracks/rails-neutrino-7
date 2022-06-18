#!/bin/bash
set -e

# Install and set up the Devise gem.

# AGENDA
# * Add the devise gem to the Gemfile.
# * Create the config/initializers/devise.rb and config/locales/devise.en.yml files.
# * Change the email address in config/initializers/devise.rb to somebody@rubyonracetracks.com

echo '######'
echo 'Devise'
echo '######'

ruby mod-09-01.rb

git add .
git commit -m "Added and configured Devise"
