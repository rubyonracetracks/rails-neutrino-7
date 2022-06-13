#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'gemfile_entry'
require 'string_in_file'
require 'line_containing'

# WICHTIG/LEGACY/bash: Enable docker/outline-short in docker/git_check
StringInFile.replace('# docker/outline-short', 'docker/outline-short', 'docker/git_check')
system('chmod +x docker/git_check', exception: true)

# WICHTIG/LEGACY/bash: Enable docker/outline in docker/build-log
StringInFile.replace('# docker/outline', 'docker/outline', 'docker/build-log')
system('chmod +x docker/build-log', exception: true)
