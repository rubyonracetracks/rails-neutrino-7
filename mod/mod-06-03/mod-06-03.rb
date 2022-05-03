#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'

# WICHTIG/LEGACY/recommended: add better_errors and binding_of_caller to the Gemfile
puts 'Adding better_errors and binding_of_caller to the Gemfile'
InsertFromFile.add_end('mod-06-03-Gemfile.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'better_errors'", GemfileEntry.active('better_errors').to_s, 'Gemfile')
StringInFile.replace("gem 'binding_of_caller'", GemfileEntry.active('binding_of_caller').to_s, 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
