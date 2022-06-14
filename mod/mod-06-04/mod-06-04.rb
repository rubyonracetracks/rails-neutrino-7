#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'

# WICHTIG/LEGACY/recommended: add pry-rails to the Gemfile
puts 'Adding pry-rails to the Gemfile'
InsertFromFile.add_end('mod-06-04-Gemfile.txt', 'Gemfile')
puts 'bundle update --quiet'
system('bundle update --quiet', exception: true)
StringInFile.replace("gem 'pry-rails'", GemfileEntry.active('pry-rails').to_s, 'Gemfile')
StringInFile.replace("gem 'method_source'", GemfileEntry.active('method_source').to_s, 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
