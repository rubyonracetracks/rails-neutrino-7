#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'
require 'replace_quotes'
require 'remove_double_blank'
require 'line_containing'

puts 'Updating the Gemfile'
InsertFromFile.add_end('mod-03-01-Gemfile.txt', 'Gemfile')

puts 'Enabling docker/brakeman in docker/test_code'
StringInFile.replace('# docker/brakeman', 'docker/brakeman', 'docker/test_code')
system('chmod +x docker/test_code', exception: true)

puts 'Enabling docker/brakeman in docker/git_check'
StringInFile.replace('# docker/brakeman', 'docker/brakeman', 'docker/git_check')
system('chmod +x docker/git_check', exception: true)

puts 'Forcing SSL in config/environments/production.rb'
puts 'This addresses an issue flagged by Brakeman.'
StringInFile.replace('# config.force_ssl = true', 'config.force_ssl = true', 'config/environments/production.rb')
