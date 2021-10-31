#!/bin/bash
set -e

DIR_MAIN=$PWD

# Basic parameters
RAILS_VERSION=`cat tmp/rails_version.txt`
MODE=`cat tmp/mode.txt`
STAGE=`cat tmp/stage.txt`
APP_NAME=`cat tmp/app_name.txt`
TIME_STAMP=`cat tmp/time_stamp.txt`
DIR_APP=$DIR_MAIN/$APP_NAME

ANNOTATE=`cat tmp/annotate.txt`

UNIT_00=`cat tmp/unit00.txt`
UNIT_01=`cat tmp/unit01.txt`
UNIT_02=`cat tmp/unit02.txt`
UNIT_03=`cat tmp/unit03.txt`
UNIT_04=`cat tmp/unit04.txt`
UNIT_05=`cat tmp/unit05.txt`

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
  cd $DIR_APP && bash mod_app.sh '01-01' $TOGGLE_OUTLINE
else
  get_prev_app
  prepare_mod_app
fi

###############
# DOCKERIZATION
###############
if [ "$UNIT_01" = 'Y' ]
then
  cd $DIR_APP && bash mod_app.sh '01-02' $TOGGLE_OUTLINE
  cd $DIR_APP && bash mod_app.sh '01-03' $TOGGLE_OUTLINE
  cd $DIR_APP && bash mod_app.sh '01-04' $TOGGLE_OUTLINE
  cd $DIR_APP && bash mod_app.sh '01-05' $TOGGLE_OUTLINE
  # cd $DIR_APP && bash mod_app.sh '01-06' $TOGGLE_OUTLINE
  # cd $DIR_APP && bash mod_app.sh '01-07' $TOGGLE_OUTLINE
  # cd $DIR_APP && bash mod_app.sh '01-08' $TOGGLE_OUTLINE
  # cd $DIR_APP && bash mod_app.sh '01-09' $TOGGLE_OUTLINE
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
  echo '---------------------'
  echo 'yarn install --silent'
  cd $DIR_APP && yarn install --silent

  echo '----------------------'
  echo 'bundle install --quiet'
  cd $DIR_APP && bundle install --quiet

  # Skip the migration until docker/migrate is provided
  if [ -f $DIR_APP/docker/migrate ]; then
    echo '---------------------------'
    echo 'bundle exec rake db:migrate'
    cd $DIR_APP && bundle exec rake db:migrate
  fi
  
  # Skip the testing until docker/test is provided
  if [ -f $DIR_APP/docker/test ]; then
    echo '---------------------'
    echo 'bundle exec rake test'
    cd $DIR_APP && bundle exec rake test
  fi

  # Skip RuboCop until docker/cop-auto is provided
  if [ -f $DIR_APP/docker/cop-auto ]; then
    echo '----------------------'
    echo 'bundle exec rubocop -D'
    cd $DIR_APP && bundle exec rubocop -D
  fi

  # Skip Rails Best Practices until docker/rbp is provided
  if [ -f $DIR_APP/docker/rbp ]; then
    echo '----------------------------------'
    echo 'bundle exec rails_best_practices .'
    cd $DIR_APP && bundle exec rails_best_practices .
  fi

  # Skip Brakeman until bin/brakeman is provided
  if [ -f $DIR_APP/bin/brakeman ]; then
    cd $DIR_APP && bin/brakeman
  fi

  # Skip bundler-audit until bin/audit is provided
  if [ -f $DIR_APP/bin/audit ]; then
    cd $DIR_APP && bin/audit
  fi

  if [ -f $DIR_APP/docker/build ]; then
    echo 'From your HOST environment, run the "docker/build" script'
    echo 'from within the root directory of your new app.'
  fi
else
  echo 'Using the "docker/build" script to test the new app'
fi

echo '**********************************'
echo 'Your new Rails app has been built!'
echo 'Path:'
echo "$DIR_APP"

DATE_END=$(date +%s)
T_SEC=$((DATE_END-DATE_START))
echo "Time used to build this app:"
echo "$((T_SEC/60)) minutes and $((T_SEC%60)) seconds"

##########################################
# RuboCop for Rails Neutrino 6 Source Code
##########################################

echo '--------------------------'
echo "cd $DIR_MAIN && rubocop -D"
cd $DIR_MAIN && rubocop -D
