#!/bin/bash
set -e

# AGENDA
# * Creating the user and admin models
# * Making the test fixtures blank so that the tests pass

echo '##################################'
echo 'Creating the User and Admin Models'
echo '##################################'

echo '------------------------------'
echo 'bin/rails generate devise user'
bin/rails generate devise user
wait
echo '-------------------------------'
echo 'bin/rails generate devise admin'
bin/rails generate devise admin
wait
echo '---------------------------'
echo 'bundle exec rake db:migrate'
bundle exec rake db:migrate

echo 'Making the user and admin test fixtures blank so that tests pass'
cp mod-09-02-test_fixtures_initial.yml test/fixtures/users.yml
cp mod-09-02-test_fixtures_initial.yml test/fixtures/admins.yml

ruby mod-09-02.rb

# BEGIN: annotate
if [ "$ANNOTATE" = 'Y' ]
then
  bin/annotate
else
  echo 'Skipping the annotation process to save time'
fi
# END: annotate

git add .
git commit -m "Created the user and admin models"
