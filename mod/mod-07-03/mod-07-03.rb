#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'gemfile_entry'
require 'string_in_file'
require 'line_containing'

# WICHTIG: Add the railroady and rails-erd gems to the Gemfile
puts 'Updating the Gemfile'
InsertFromFile.add_end('mod-07-03-Gemfile.txt', 'Gemfile')

# WICHTIG: Add bin/replace_sif
system('mv mod-07-03-bin-replace_sif bin/replace_sif', exception: true)
system('chmod +x bin/replace_sif', exception: true)

# WICHTIG: Add bin/railroady for using the railroady gem
system('mv mod-07-03-bin-railroady bin/railroady', exception: true)
system('chmod +x bin/railroady', exception: true)

# WICHTIG: Add bin/rails-erd for using the rails-erd gem
system('mv mod-07-03-bin-rails-erd bin/rails-erd', exception: true)
system('chmod +x bin/rails-erd', exception: true)

# WICHTIG: Add docker/railroady for running bin/railroady in Docker
system('mv mod-07-03-docker-railroady docker/railroady', exception: true)
system('chmod +x docker/railroady', exception: true)

# WICHTIG: Add docker/rails-erd for running bin/rails-erd in Docker
system('mv mod-07-03-docker-rails-erd docker/rails-erd', exception: true)
system('chmod +x docker/rails-erd', exception: true)

# WICHTIG: Add docker/outline-long for executing bin/railroady and bin/rails-erd in Docker
system('mv mod-07-03-docker-outline-long docker/outline-long', exception: true)
system('chmod +x docker/outline-long', exception: true)

# WICHTIG: Enable docker/outline-long in docker/outline
StringInFile.replace('# docker/outline-long', 'docker/outline-long', 'docker/outline')
system('chmod +x docker/outline', exception: true)
