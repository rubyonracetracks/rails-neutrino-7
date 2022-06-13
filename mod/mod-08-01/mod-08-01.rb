#!/usr/bin/ruby
# frozen_string_literal: true

require 'line_containing'

puts 'Adding title helper test'
system('mv mod-08-01-application_helper_test.rb test/helpers/application_helper_test.rb', exception: true)

puts 'Adding title helper'
system('mv mod-08-01-application_helper.rb app/helpers/application_helper.rb', exception: true)

puts 'Making test/helpers/application_helper_test.rb exempt from Layout/LineLength cop'
LineContaining.add_before('# END: Layout/LineLength', '    - test/helpers/application_helper_test.rb', '.rubocop.yml')
