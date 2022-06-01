# frozen_string_literal: true

module ApplicationHelper
  # BEGIN: full_title
  # Returns the full title on a per-page basis
  def full_title(page_title = '')
    base_title = 'Generic App Template'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end
  # END: full_title
end
