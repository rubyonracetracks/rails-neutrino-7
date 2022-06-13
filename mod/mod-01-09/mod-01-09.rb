#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'
require 'remove_double_blank'

# Enable docker/test in docker/build-log
StringInFile.replace('#TEST_APP ', '', 'docker/build-log')
RemoveDoubleBlank.update('docker/build-log')
system('chmod +x docker/build-log', exception: true)

puts 'Adding rexml to the Gemfile'
InsertFromFile.add_end('mod-01-09-Gemfile.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
StringInFile.replace("gem 'rexml'", GemfileEntry.active('rexml'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
