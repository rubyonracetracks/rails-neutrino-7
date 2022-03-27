#!/bin/bash
set -e

# AGENDA
# * Replace Heroku's default WEBrick server with Puma, which can handle
#   far more web traffic.  Do this by updating the config/puma.rb file
#   and by adding the Procfile and specifying Puma in it.

echo '###################################'
echo 'Updating the Production Environment'
echo '###################################'

# WICHTIG/LEGACY/production: update config/puma.rb (if necessary)
echo 'Updating config/puma.rb'
mv mod-04-03-puma.rb config/puma.rb

# WICHTIG/LEGACY/production: update the Procfile (if necessary)
echo 'Specifying the use of Puma in the Procfile'
mv mod-04-03-Procfile Procfile

git add .
git commit -m "Using Puma in the production environment"
