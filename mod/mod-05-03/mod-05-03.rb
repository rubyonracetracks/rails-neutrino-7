#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'
require 'gemfile_entry'

puts 'Adding capybara-email and capybara-slow_finder_errors to the Gemfile'
InsertFromFile.add_end('mod-05-03-add_to_Gemfile.txt', 'Gemfile')
puts 'bundle update --quiet'
system('bundle update --quiet')
puts 'Pinning the versions of capybara, capybara-email, and capybara-slow_finder_errors'
LineContaining.replace("gem 'capybara'", "  #{GemfileEntry.active('capybara')}", 'Gemfile')
StringInFile.replace("gem 'capybara-email'", GemfileEntry.active('capybara-email'), 'Gemfile')
StringInFile.replace("gem 'capybara-slow_finder_errors'",
                     GemfileEntry.active('capybara-slow_finder_errors'),
                     'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')

puts 'Adding the Capybara setup to test/test_helper.rb'
InsertFromFile.add_end('mod-05-03-add_to_test_helper.txt', 'test/test_helper.rb')

puts 'Adding second integration test'
system('bundle exec rails generate integration_test test2')
system('wait')
InsertFromFile.add_after('mod-05-03-test2.txt', 'test/integration/test2_test.rb',
                         'class Test2Test < ActionDispatch::IntegrationTest')
StringInFile.replace('"', "'", 'test/integration/test2_test.rb')
StringInFile.add_beginning("# frozen_string_literal: true\n\n", 'test/integration/test2_test.rb')

puts 'Adding third integration test'
system('bundle exec rails generate integration_test test3')
system('wait')
InsertFromFile.add_after('mod-05-03-test3.txt', 'test/integration/test3_test.rb',
                         'class Test3Test < ActionDispatch::IntegrationTest')
StringInFile.replace('require "test_helper"', "require 'test_helper'", 'test/integration/test3_test.rb')
StringInFile.add_beginning("# frozen_string_literal: true\n\n", 'test/integration/test3_test.rb')

puts 'Updating public/index.html and public/about.html so that all integration tests pass'
system('mv mod-05-03-public_index.html public/index.html')
system('mv mod-05-03-public_about.html public/about.html')
