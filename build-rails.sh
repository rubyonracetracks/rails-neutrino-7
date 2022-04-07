#!/bin/bash
set -e

# NOTE: Do NOT use "set -u".  This causes errors in RVM.

DIR_MAIN=$PWD

# Basic parameters
source definitions.sh

if [ "$MODE" = 'H' ]
then
  echo 'Setting Git credentials'
  git config --global user.email 'docker_user@rubyonractracks.com'
  git config --global user.name 'Rails Neutrino'
fi

# Get Git credentials
bash credentials.sh

# Start tracking the time needed to build app
DATE_START=$(date +%s)

# Display parameters
echo '----------'
echo 'Git email:'
git config --global user.email
echo ''
echo '---------'
echo 'Git name:'
git config --global user.name
echo ''
echo "Rails Version: $RAILS_VERSION"
echo "Mode: $MODE"
echo "Stage: $STAGE"
echo ''
echo "App Name: $APP_NAME"
echo "Time Stamp: $TIME_STAMP"
echo ''
echo "Main Directory: $DIR_MAIN"
echo "App Directory: $DIR_APP"
echo ''
echo "App Annotations: $ANNOTATE"
echo ''
echo '-----------------'
echo 'Scope parameters:'
echo ''
echo "Create app from scratch?              $UNIT_00"
echo ''
echo "Dockerize?                            $UNIT_01"
echo ''
echo "Add Lint?                             $UNIT_02"
echo ''
echo "Add vulnerability tests?              $UNIT_03"
echo ''
echo "Configure production environment?     $UNIT_04"
echo ''
echo "Configure testing environment?        $UNIT_05"
echo ''

####################################################################
# Activate NVM and RVM if this script was triggered from the host OS
####################################################################
if [ "$MODE" = 'H' ]
then
  export NVM_DIR="/home/`whoami`/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm use node

  export PATH="$PATH:$HOME/.rvm/bin"
  source ~/.rvm/scripts/rvm
fi

#######################
# Initial sanity checks
#######################

echo '-------'
echo 'ruby -v'
ruby -v

echo '-------------------'
echo 'cat /etc/os-release'
cat /etc/os-release
echo ''

echo '-----------------'
echo 'bundler --version'
bundler --version
echo ''

echo '--------------------'
echo 'gem list "^bundler$"'
gem list "^bundler$"
echo ''

echo '--------'
echo 'rails -v'
rails -v
echo ''

echo '--------------------------------'
echo 'BEGIN: installing necessary gems'
echo '--------------------------------'
gem install insert_from_file
gem install line_containing
gem install gemfile_entry
gem install string_in_file
gem install replace_quotes
gem install remove_double_blank
gem install rubocop
echo '------------------------------'
echo 'END: installing necessary gems'
echo '------------------------------'

########################################
# 01-01: Initial app creation/acqusition
########################################
prepare_mod_app () {
  cp $DIR_MAIN/mod_app.sh $DIR_APP
  wait
  cp -R $DIR_MAIN/mod $DIR_APP
  wait
}

get_prev_app () {
  STAGE_PREV=$((STAGE-1))
  APP_NAME_PREV="rails$RAILS_VERSION$MODE$STAGE_PREV"
  DIR_APP_PREV=$DIR_MAIN/$APP_NAME_PREV
  echo '------------------------'
  echo 'Copying the previous app'
  echo "$APP_NAME_PREV"
  cp -R $DIR_APP_PREV $DIR_APP
}

if [ "$UNIT_00" = 'Y' ]
then
  # Create new app from scratch
  echo '--------------------------'
  echo "BEGIN: rails new $APP_NAME"
  echo '--------------------------'
  cd $DIR_MAIN && rails new $APP_NAME
  echo '------------------------'
  echo "END: rails new $APP_NAME"
  echo '------------------------'
  echo "$TIME_STAMP" > $DIR_APP/config/time_stamp.txt
  prepare_mod_app
  cd $DIR_APP && bash mod_app.sh '01-01'
else
  get_prev_app
  prepare_mod_app
fi

###############
# DOCKERIZATION
###############
if [ "$UNIT_01" = 'Y' ]
then
  echo '###################'
  echo 'UNIT 1: BASIC SETUP'
  echo '###################'
  cd $DIR_APP && bash mod_app.sh '01-02'
  cd $DIR_APP && bash mod_app.sh '01-03'
  cd $DIR_APP && bash mod_app.sh '01-04'
  cd $DIR_APP && bash mod_app.sh '01-05'
  cd $DIR_APP && bash mod_app.sh '01-06'
  cd $DIR_APP && bash mod_app.sh '01-07'
  cd $DIR_APP && bash mod_app.sh '01-08'
  cd $DIR_APP && bash mod_app.sh '01-09'
fi

######
# LINT
######
if [ "$UNIT_02" = 'Y' ]
then
  echo '############'
  echo 'UNIT 2: LINT'
  echo '############'
  cd $DIR_APP && bash mod_app.sh '02-01'
  cd $DIR_APP && bash mod_app.sh '02-02'
  cd $DIR_APP && bash mod_app.sh '02-03'
  cd $DIR_APP && bash mod_app.sh '02-04'
  cd $DIR_APP && bash mod_app.sh '02-05'
fi

########################
# VULNERABILITY CHECKING
########################
if [ "$UNIT_03" = 'Y' ]
then
  echo '#############################'
  echo 'UNIT 3: VULNERABILITY TESTING'
  echo '#############################'
  cd $DIR_APP && bash mod_app.sh '03-01'
  cd $DIR_APP && bash mod_app.sh '03-02'
  cd $DIR_APP && bash mod_app.sh '03-03'
fi

########################
# PRODUCTION ENVIRONMENT
########################
if [ "$UNIT_04" = 'Y' ]
then
  echo '##############################'
  echo 'UNIT 4: PRODUCTION ENVIRONMENT'
  echo '##############################'
  cd $DIR_APP && bash mod_app.sh '04-01'
  cd $DIR_APP && bash mod_app.sh '04-02'
  cd $DIR_APP && bash mod_app.sh '04-03'
fi

#########
# TESTING
#########
if [ "$UNIT_05" = 'Y' ]
then
  echo '##################'
  echo 'UNIT 5: TEST SETUP'
  echo '##################'
  cd $DIR_APP && bash mod_app.sh '05-01'
  cd $DIR_APP && bash mod_app.sh '05-02'
  cd $DIR_APP && bash mod_app.sh '05-03'
  cd $DIR_APP && bash mod_app.sh '05-04'
fi

#########
# CLEANUP
#########
# Remove the mod* files from the new app

echo 'Cleaning up the app'
rm -rf $DIR_APP/mod
rm $DIR_APP/mod*

#############################################################################
# FINAL TESTING (skip if Rails Neutrino is activated in the host environment)
#############################################################################
if [ "$MODE" = 'V' ]
then
  cd $DIR_APP && $DIR_MAIN/test_app_internal
fi

echo '**********************************'
echo 'Your new Rails app has been built!'
echo 'Path:'
echo "$DIR_APP"

DATE_END=$(date +%s)
T_SEC=$((DATE_END-DATE_START))
echo "Time used to build this app:"
echo "$((T_SEC/60)) minutes and $((T_SEC%60)) seconds"

############################################
# RuboCop for the Rails Neutrino Source Code
############################################

echo '------------------------------------------'
echo "RuboCop for the Rails Neutrino Source Code"
cd $DIR_MAIN && rubocop -D
