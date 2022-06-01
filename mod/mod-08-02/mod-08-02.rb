#!/usr/bin/ruby
# frozen_string_literal: true

require 'string_in_file'
require 'gemfile_entry'
require 'insert_from_file'
require 'line_containing'

puts 'Generating static pages'
system('bin/rails generate controller StaticPages home about contact')
system('wait')

puts 'Filling in static pages controller test'
StringInFile.add_beginning("# frozen_string_literal: true\n\n", 'test/controllers/static_pages_controller_test.rb')
StringInFile.replace('require "test_helper"', "require 'test_helper'",
                     'test/controllers/static_pages_controller_test.rb')
StringInFile.replace('  end', '', 'test/controllers/static_pages_controller_test.rb')
LineContaining.delete_between('class StaticPagesControllerTest < ActionDispatch::IntegrationTest', 'end',
                              'test/controllers/static_pages_controller_test.rb')
InsertFromFile.add_after('mod-08-02-static_pages_controller_test.txt',
                         'test/controllers/static_pages_controller_test.rb',
                         'class StaticPagesControllerTest < ActionDispatch::IntegrationTest')

puts 'Updating config/routes.rb'
system('mv mod-08-02-routes.rb config/routes.rb')

puts 'Removing unused static pages helper'
system('rm app/helpers/static_pages_helper.rb')

puts 'Updating static pages controller'
StringInFile.add_beginning("# frozen_string_literal: true\n\n", 'app/controllers/static_pages_controller.rb')
StringInFile.replace('  end', '', 'app/controllers/static_pages_controller.rb')
LineContaining.delete_between('class StaticPagesController < ApplicationController', 'end',
                              'app/controllers/static_pages_controller.rb')
InsertFromFile.add_after('mod-08-02-static_pages_controller.txt', 'app/controllers/static_pages_controller.rb',
                         'class StaticPagesController < ApplicationController')
StringInFile.add_beginning("#\n", 'app/controllers/static_pages_controller.rb')
