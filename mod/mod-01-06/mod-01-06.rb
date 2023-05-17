#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'
require 'remove_double_blank'

# Enable docker/migrate in docker/build-log
StringInFile.replace('#DATABASE_MIGRATE ', '', 'docker/build-log')

system('chmod +x docker/build-log', exception: true)

# WICHTIG: Add the dartsass-rails gem to the Gemfile
# Database migrations and rails generate do NOT work without this gem.
puts 'Updating the Gemfile'
InsertFromFile.add_end('mod-01-06-Gemfile.txt', 'Gemfile')
puts 'bundle update --quiet'
system('bundle update --quiet', exception: true)
StringInFile.replace("gem 'dartsass-rails'", GemfileEntry.active('dartsass-rails').to_s, 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
