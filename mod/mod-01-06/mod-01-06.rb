#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'
require 'remove_double_blank'

# Enable docker/migrate in docker/build-log
StringInFile.replace('#DATABASE_MIGRATE ', '', 'docker/build-log')

system('chmod +x docker/build-log')
