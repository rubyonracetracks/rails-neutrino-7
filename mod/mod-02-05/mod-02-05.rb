#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'

puts 'Updating the Gemfile'
LineContaining.add_after("gem 'rubocop-rails'", "  # gem 'sandi_meter'", 'Gemfile')
