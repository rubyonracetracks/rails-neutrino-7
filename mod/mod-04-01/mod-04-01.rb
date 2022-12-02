#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'remove_double_blank'

# MUST execute "bundle install" before using the gemfile_entry gem.
# Not executing "bundle install" in the CI environment
# causes the gemfile_entry gem to choke.
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)

# WICHTIG/LEGACY/all_or_nothing: pin rails, sqlite/pg, and other gems
puts 'Pinning rails'
LineContaining.delete('Bundle edge Rails', 'Gemfile')
LineContaining.replace("gem 'rails'", GemfileEntry.active('rails').to_s, 'Gemfile')

puts 'Limiting sqlite to the development and testing environments; pinning sqlite'
LineContaining.delete('# Use sqlite3 as the database for Active Record', 'Gemfile')
InsertFromFile.replace('mod-04-01-Gemfile-sqlite.txt', 'Gemfile', "gem 'sqlite3'")
LineContaining.replace("gem 'sqlite3'", "  #{GemfileEntry.active('sqlite3')}", 'Gemfile')
RemoveDoubleBlank.update('Gemfile')

# Skipping the following step results in Illformed requirement error (for sqlite) when running "bundle install"
StringInFile.replace('x86_64linux', '', 'Gemfile')

puts 'Adding the pg section to the Gemfile; pinning pg'
InsertFromFile.add_end('mod-04-01-Gemfile-pg.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
LineContaining.replace("gem 'pg'", "  #{GemfileEntry.active('pg')}", 'Gemfile')

puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
