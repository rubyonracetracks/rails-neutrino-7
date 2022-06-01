#!/usr/bin/ruby
# frozen_string_literal: true

require 'string_in_file'
require 'gemfile_entry'

# WICHTIG/LEGACY/all_or_nothing: add Bootstrap (if necessary)
puts 'Adding bootstrap-sass to the Gemfile'
StringInFile.add_end("\n", 'Gemfile')
StringInFile.add_end("gem 'bootstrap-sass' # Bootstrap styling\n", 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')
StringInFile.replace("gem 'bootstrap-sass'", GemfileEntry.active('bootstrap-sass'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet')

system('mv mod-08-04-custom.scss app/assets/stylesheets/custom.scss')

# NOTE: If you were going through the Rails Neutrino steps manually,
# you would need to restart the local web server at this point to avoid
# getting a syntax error message when reloading the page.
