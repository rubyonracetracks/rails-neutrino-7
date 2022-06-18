#!/usr/bin/ruby
# frozen_string_literal: true

require 'gemfile_entry'
require 'insert_from_file'
require 'line_containing'
require 'string_in_file'

puts 'Adding devise to the Gemfile'
StringInFile.add_end("\n", 'Gemfile')
StringInFile.add_end("gem 'devise' # Provides admin/user authentication\n", 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)

StringInFile.replace("gem 'devise'", GemfileEntry.active('devise'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)

puts 'bin/rails generate devise:install'
system('bin/rails generate devise:install')

puts 'Updating the subject lines of email messages in config/locales/devise.en.yml'
StringInFile.replace('Confirmation instructions', 'Generic App Template: Confirmation instructions',
                     'config/locales/devise.en.yml')
StringInFile.replace('Reset password instructions', 'Generic App Template: Reset password instructions',
                     'config/locales/devise.en.yml')
StringInFile.replace('Unlock instructions', 'Generic App Template: Unlock instructions', 'config/locales/devise.en.yml')
StringInFile.replace('Email Changed', 'Generic App Template: Email Changed', 'config/locales/devise.en.yml')
StringInFile.replace('Password Changed', 'Generic App Template: Password Changed', 'config/locales/devise.en.yml')

puts 'Updating the email address in config/initializers/devise.rb'
LineContaining.replace('config.mailer_sender', "  config.mailer_sender = 'somebody@rubyonracetracks.com'",
                       'config/initializers/devise.rb')

puts 'Removing trailing white spaces in config/initializers/devise.rb'
StringInFile.replace("  \n", "\n", 'config/initializers/devise.rb')

puts 'Updating the config.scoped_views setting in config/initializers/devise.rb'
puts '(allows the use of custom mailer views)'
LineContaining.replace('config.scoped_views', '  config.scoped_views = true', 'config/initializers/devise.rb')

puts 'Updating .rubocop.yml'
InsertFromFile.add_end('mod-09-01-rubocop.txt', '.rubocop.yml')
