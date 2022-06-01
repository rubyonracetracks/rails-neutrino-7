# frozen_string_literal: true

require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title, 'Generic App Template'
    assert_equal full_title('About'), 'About | Generic App Template'
    assert_equal full_title('Contact'), 'Contact | Generic App Template'
    assert_equal full_title('Michael Hartl'), 'Michael Hartl | Generic App Template'
  end
end
