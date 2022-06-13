#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'
require 'replace_quotes'
require 'remove_double_blank'
require 'line_containing'

puts 'Enabling docker/audit in docker/test_code'
StringInFile.replace('# docker/audit', 'docker/audit', 'docker/test_code')
system('chmod +x docker/test_code', exception: true)
