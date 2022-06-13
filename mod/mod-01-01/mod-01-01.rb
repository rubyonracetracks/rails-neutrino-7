#!/usr/bin/ruby
# frozen_string_literal: true

require 'insert_from_file'

puts '-------------------------------------------------'
puts 'Updating the Gemfile to mark the initial contents'
InsertFromFile.add_beginning('mod-01-01-Gemfile_start.txt', 'Gemfile')
InsertFromFile.add_end('mod-01-01-Gemfile_end.txt', 'Gemfile')

# WICHTIG/LEGACY/main: Remove instances of .DS_Store in repository
system("find . -name '.DS_Store' -type f -delete", exception: true)

puts '-----------------------------------------------------------'
puts 'Updating .gitignore to mark the initial contents and to add'
puts 'pesky files you do not want committed, such as .DS_Store.'

InsertFromFile.add_beginning('mod-01-01-gitignore_start.txt', '.gitignore')
InsertFromFile.add_end('mod-01-01-gitignore_end.txt', '.gitignore')

def fill_in_gitignore(platform)
  url = "raw.githubusercontent.com/github/gitignore/master/Global/#{platform}.gitignore"
  filename = "mod-01-01-gitignore-#{platform}.txt"

  puts '---------------------------------'
  puts "Downloading #{url} to #{filename}"
  system("curl -o #{filename} -OL #{url}", exception: true)
  sleep 0.01

  puts '--------------------------------------------------------'
  puts "Adding selected #{platform}-specific files to .gitignore"
  InsertFromFile.add_after(filename.to_s, '.gitignore', url.to_s)
end

# Add MacOS configuration files to .gitignore
# WICHTIG/LEGACY/main: Add .DS_Store to .gitignore
fill_in_gitignore('macOS')

# Add Windows configuration files to .gitignore
fill_in_gitignore('Windows')

# Add Linux configuration files to .gitignore
fill_in_gitignore('Linux')
