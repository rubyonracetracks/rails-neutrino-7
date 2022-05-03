#!/bin/bash
set -e

# Adding MailCatcher for simulating the email interactions

# AGENDA
# * Update config/environments/development.rb.
# * Update docker-compose.yml

# NOTE: MailCatcher is NOT added to the Gemfile, because it will likely
# conflict with other gems sooner or later.

echo '###########'
echo 'MailCatcher'
echo '###########'

ruby mod-06-02.rb

git add .
git commit -m "Added MailCatcher"
