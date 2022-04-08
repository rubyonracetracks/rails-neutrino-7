#!/bin/bash
set -e

# Provide scripts for converting from SQLite3 to PostgreSQL

# AGENDA
# * Adding line_containing, remove_double_blank, and string_in_file to the Gemfile
# * Add config/database-pg.yml, docker/pg_setup, pg_setup.rb,
#   .env-docker/development/database-template, .env-docker/development/web, and
#   init.sql.template

echo '########################'
echo 'PostgreSQL Setup Scripts'
echo '########################'

echo 'Adding config/database-pg.yml'
mv mod-06-01-database-pg.yml config/database-pg.yml

echo 'Adding docker/pg_setup_1'
mv mod-06-01-pg_setup_1 docker/pg_setup_1
chmod +x docker/pg_setup_1

echo 'Adding docker/pg_setup_2'
mv mod-06-01-pg_setup_2 docker/pg_setup_2
chmod +x docker/pg_setup_2

echo 'Adding docker/replace_sif'
mv mod-06-01-replace_sif docker/replace_sif
chmod +x docker/replace_sif

echo 'mkdir -p .env-docker/development'
mkdir -p .env-docker/development

echo 'Adding .env-docker/development/database-template'
mv mod-06-01-env-development-database-template .env-docker/development/database-template

echo 'Adding .env-docker/development/web' 
mv mod-06-01-env-development-web .env-docker/development/web

echo 'Adding init.sql.template'
mv mod-06-01-init-sql-template init.sql.template

ruby mod-06-01.rb

git add .
git commit -m "Added PostgreSQL setup scripts"
