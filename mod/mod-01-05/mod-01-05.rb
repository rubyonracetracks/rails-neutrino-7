#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'
require 'line_containing'
require 'gemfile_entry'
require 'string_in_file'
require 'remove_double_blank'

# Remove docker/gem_install_bundler from docker/build-log
StringInFile.replace('docker/gem_install_bundler', '', 'docker/build-log')
StringInFile.replace("\n\n", "\n", 'docker/build-log')

# Enable docker/bundle_install in docker/build-log
StringInFile.replace('#BUNDLE_INSTALL ', '', 'docker/build-log')

RemoveDoubleBlank.update('docker/build-log')
system('chmod +x docker/build-log')
