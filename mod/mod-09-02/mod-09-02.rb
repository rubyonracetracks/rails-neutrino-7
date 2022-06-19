#!/usr/bin/ruby
# frozen_string_literal: true

require 'line_containing'
require 'insert_from_file'
require 'string_in_file'

puts 'Updating app/models/user.rb'
LineContaining.add_before('class User < ApplicationRecord', "# frozen_string_literal: true\n", 'app/models/user.rb')
LineContaining.add_after('class User < ApplicationRecord', '  # BEGIN: devise section', 'app/models/user.rb')
LineContaining.add_after('class User < ApplicationRecord', '  # BEGIN: public section', 'app/models/user.rb')
LineContaining.add_before('end', '  # END: devise section', 'app/models/user.rb')
LineContaining.add_before('end', '  # END: public section', 'app/models/user.rb')
InsertFromFile.replace_between('mod-09-02-devise.txt', 'app/models/user.rb', '# BEGIN: devise section',
                               '# END: devise section')

puts 'Updating app/models/admin.rb'
LineContaining.add_before('class Admin < ApplicationRecord', "# frozen_string_literal: true\n", 'app/models/admin.rb')
LineContaining.add_after('class Admin < ApplicationRecord', '  # BEGIN: devise section', 'app/models/admin.rb')
LineContaining.add_after('class Admin < ApplicationRecord', '  # BEGIN: public section', 'app/models/admin.rb')
LineContaining.add_before('end', '  # END: devise section', 'app/models/admin.rb')
LineContaining.add_before('end', '  # END: public section', 'app/models/admin.rb')
InsertFromFile.replace_between('mod-09-02-devise.txt', 'app/models/admin.rb', '# BEGIN: devise section',
                               '# END: devise section')

puts 'Updating test/models/user_test.rb'
StringInFile.replace('require "test_helper"', "require 'test_helper'", 'test/models/user_test.rb')
LineContaining.add_before('test_helper', "# frozen_string_literal: true\n", 'test/models/user_test.rb')

puts 'Updating test/models/admin_test.rb'
StringInFile.replace('require "test_helper"', "require 'test_helper'", 'test/models/admin_test.rb')
LineContaining.add_before('test_helper', "# frozen_string_literal: true\n", 'test/models/admin_test.rb')
