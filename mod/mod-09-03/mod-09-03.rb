#!/usr/bin/ruby
# frozen_string_literal: true

require 'string_in_file'
require 'line_containing'
require 'insert_from_file'
require 'gemfile_entry'

puts 'Adding the faker gem to the Gemfile'
InsertFromFile.add_end('mod-09-03-Gemfile.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'faker'", GemfileEntry.active('faker'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')

puts 'Adding user model tests'
StringInFile.replace('  # end', '', 'test/models/user_test.rb')
LineContaining.delete_between('class UserTest < ActiveSupport::TestCase', 'end', 'test/models/user_test.rb')
InsertFromFile.add_after('mod-09-03-user_test.txt', 'test/models/user_test.rb',
                         'class UserTest < ActiveSupport::TestCase')

puts 'Adding user parameters'
system('bundle exec rails generate migration add_params_to_users name:string username:string:uniq')
sleep 0.01
system('bundle exec rake db:migrate:reset')
sleep 0.01

# rubocop:disable Style/MutableConstant
FILE_MIGRATE = `ls db/migrate/*_devise_create_users.rb`
# rubocop:enable Style/MutableConstant
FILE_MIGRATE.slice! "\n"
puts "Updating #{FILE_MIGRATE} to make users confirmable and lockable"
StringInFile.replace('# t.string', 't.string', FILE_MIGRATE)
StringInFile.replace('# t.datetime', 't.datetime', FILE_MIGRATE)
StringInFile.replace('# t.integer', 't.integer', FILE_MIGRATE)
StringInFile.replace('# add_index', 'add_index', FILE_MIGRATE)

system('bundle exec rake db:migrate:reset')
sleep 0.01

puts 'Adding conditions section to app/models/user.rb'
InsertFromFile.add_before('mod-09-03-user-constraints.txt', 'app/models/user.rb', '# END: public section')

puts 'Adding private section to app/models/user.rb'
InsertFromFile.add_after('mod-09-03-user-private.txt', 'app/models/user.rb', '# END: public section')

puts 'Updating the password length in config/initializers/devise.rb'
LineContaining.replace('config.password_length', '  config.password_length = 10..128',
                       'config/initializers/devise.rb')

puts 'Updating test/fixtures/users.yml'
system('mv mod-09-03-users.yml test/fixtures/users.yml')
