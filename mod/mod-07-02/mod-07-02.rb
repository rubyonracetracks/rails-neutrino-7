#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'gemfile_entry'
require 'string_in_file'
require 'line_containing'

# WICHTIG/LEGACY/all_or_nothing: add annotate to the Gemfile
# (not recommended for legacy apps if you need to keep it out of pull requests)
puts 'Updating the Gemfile'
InsertFromFile.add_end('mod-07-02-Gemfile.txt', 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)
StringInFile.replace("gem 'annotate'", GemfileEntry.active('annotate'), 'Gemfile')
puts 'bundle install --quiet'
system('bundle install --quiet', exception: true)

# WICHTIG/LEGACY/bash: add bin/annotate
puts 'Adding bin/annotate'
system('mv mod-07-02-bin-annotate bin/annotate', exception: true)
system('chmod +x bin/annotate', exception: true)

# WICHTIG/LEGACY/bash: add docker/annotate
puts 'Adding docker/annotate'
system('mv mod-07-02-docker-annotate docker/annotate', exception: true)
system('chmod +x docker/annotate', exception: true)

# Enable docker/annotate in docker/outline-short
puts 'Enabling docker/annotate in docker/outline-short'
StringInFile.replace('# docker/annotate', 'docker/annotate', 'docker/outline-short')
system('chmod +x docker/outline-short', exception: true)
