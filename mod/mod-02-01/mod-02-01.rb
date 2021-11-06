#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'
require 'replace_quotes'
require 'remove_double_blank'
require 'line_containing'

puts 'Adding RuboCop to the Gemfile'
InsertFromFile.add_end('mod-02-01-Gemfile.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'rubocop'", GemfileEntry.active('rubocop'), 'Gemfile')
StringInFile.replace("gem 'rubocop-rails'", GemfileEntry.active('rubocop-rails'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')

puts 'Enabling docker/test_code in docker/build-log'
StringInFile.replace('# docker/test_code', 'docker/test_code', 'docker/build-log')
system('chmod +x docker/build-log')

puts 'Enabling docker/cop in docker/test_code'
StringInFile.replace('# docker/cop', 'docker/cop', 'docker/test_code')
system('chmod +x docker/test_code')

puts 'Enabling docker/cop in docker/git_check'
StringInFile.replace('# docker/cop', 'docker/cop', 'docker/git_check')
system('chmod +x docker/git_check')
