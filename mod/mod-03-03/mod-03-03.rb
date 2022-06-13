#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'
require 'replace_quotes'
require 'remove_double_blank'
require 'line_containing'

puts 'Enabling docker/bundle_outdated in docker/test_code'
StringInFile.replace('# docker/bundle_outdated', 'docker/bundle_outdated', 'docker/test_code')
system('chmod +x docker/test_code', exception: true)
