#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'gemfile_entry'
require 'string_in_file'

puts 'Adding minitest and minitest-reporters to the Gemfile'
InsertFromFile.add_end('mod-05-01-add_to_Gemfile.txt', 'Gemfile')
puts 'Adding rubocop-minitest to the Gemfile'
LineContaining.add_after("gem 'rubocop'", "  gem 'rubocop-minitest'", 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'minitest'", GemfileEntry.active('minitest'), 'Gemfile')
StringInFile.replace("gem 'minitest-reporters'", GemfileEntry.active('minitest-reporters'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')

puts 'Adding the use of minitest-reporters to test/test_helper.rb'
InsertFromFile.add_before('mod-05-01-add_to_test_helper.txt', 'test/test_helper.rb', 'module ActiveSupport')

puts 'Adding the HTML test reports to .gitignore and .dockerignore'
StringInFile.add_end("test/html_reports/\n", '.gitignore')
StringInFile.add_end("test/html_reports/\n", '.dockerignore')

# WICHTIG/LEGACY/recommended: print the command to run a failed test again (if necessary)
puts 'Adding test/rake_rerun_reporter.rb'
system('mv mod-05-01-rake_run_reporter.rb test/rake_rerun_reporter.rb')

puts 'Adding first integration test'
system('bundle exec rails generate integration_test test1')
system('wait')
InsertFromFile.add_after('mod-05-01-test1.txt', 'test/integration/test1_test.rb',
                         'class Test1Test < ActionDispatch::IntegrationTest')
StringInFile.replace('"', "'", 'test/integration/test1_test.rb')
StringInFile.add_beginning("# frozen_string_literal: true\n\n", 'test/integration/test1_test.rb')

puts 'Making the first integration test pass'
system('mv mod-05-01-public_index.html public/index.html')
