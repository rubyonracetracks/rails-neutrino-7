#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'string_in_file'

# WICHTIG/LEGACY/recommended: update config/environments/development.rb if not already done
InsertFromFile.add_after('mod-06-02-development.txt', 'config/environments/development.rb',
                         'Rails.application.configure')

# WICHTIG/LEGACY/recommended: update docker-compose.yml if not already done
StringInFile.replace('#MAILCATCHER#', '', 'docker-compose.yml')

# WICHTIG/LEGACY/recommended: update bin/derver
StringInFile.replace('#MAILCATCHER#', '', 'docker/server-log')
system('chmod +x docker/server-log', exception: true)

puts 'Updating .rubocop.yml'
InsertFromFile.add_end('mod-06-02-rubocop.txt', '.rubocop.yml')
