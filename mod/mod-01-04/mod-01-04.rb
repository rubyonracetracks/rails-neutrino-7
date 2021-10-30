#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'

StringInFile.replace('#GEM_INSTALL_BUNDLER ', '', 'docker/build-log')
system('chmod +x docker/build-log')
