#!/usr/bin/ruby
# frozen_string_literal: true

require 'string_in_file'
require 'gemfile_entry'
require 'insert_from_file'

puts 'Adding line_containing, remove_double_blank, and string_in_file to the Gemfile'
InsertFromFile.add_end('mod-06-01-Gemfile.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'line_containing'", GemfileEntry.active('line_containing'), 'Gemfile')
StringInFile.replace("gem 'remove_double_blank'", GemfileEntry.active('remove_double_blank'), 'Gemfile')
StringInFile.replace("gem 'string_in_file'", GemfileEntry.active('string_in_file'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
