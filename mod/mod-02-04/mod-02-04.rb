#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'

puts 'Updating the Gemfile'
LineContaining.add_before("gem 'rubocop'", "  gem 'rails_best_practices'", 'Gemfile')

puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'rails_best_practices'", GemfileEntry.active('rails_best_practices'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')

puts 'Updating docker/test_code'
StringInFile.replace('# docker/rbp', 'docker/rbp', 'docker/test_code')
system('chmod +x docker/test_code')

puts 'Updating docker/git_check'
StringInFile.replace('# docker/rbp', 'docker/rbp', 'docker/git_check')
system('chmod +x docker/git_check')
