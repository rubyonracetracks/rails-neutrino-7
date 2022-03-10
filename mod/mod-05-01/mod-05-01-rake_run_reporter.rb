# frozen_string_literal: true

# Original DefaultReporter:
# https://github.com/minitest-reporters/minitest-reporters/blob/master/lib/minitest/reporters/default_reporter.rb

# Redefining "def report" for providing commands for running failed tests:
# https://gist.github.com/foton/141b9f73caccf13ccfcc

# Making the green and red test reports brighter required
# redefining "def green" and "def red" in DefaultReporter.

# References on printing text with various colors/effects:
# https://kpumuk.info/ruby-on-rails/colorizing-console-ruby-script-output/
# https://gist.github.com/thebinarypenguin/3018171

# rubocop:disable Metrics/AbcSize
# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/MethodLength

require 'minitest/reporters'

module Minitest
  module Reporters
    class RakeRerunReporter < Minitest::Reporters::DefaultReporter
      # Constants needed for defining the bright green and bright red color codes:
      # The "1" is for a brighter shade of the color.
      # The semicolon is a separator.
      # The "32" is for green.  The "31" is for red.
      BRIGHT_GREEN = '1;32'
      BRIGHT_RED = '1;31'

      def ansi_code_string(color_code, string)
        "\e[#{color_code}m#{string}\e[0m"
      end

      # Original value of def green (replaced by the ansi_code_string method here):
      # color? ? ANSI::Code.green(string) : string
      # Output of "ANSI::Code.green('Hello')" in Rails console (require 'ansi'):
      #  => "\e[32mHello\e[0m"
      # Output of "puts ANSI::Code.green('Hello')":
      # Hello <in green>
      # Output of 'puts "\e[1;32mHello\e[0m"':
      # Hello <in bright green>
      def green(string)
        color? ? ansi_code_string(BRIGHT_GREEN, string) : string
      end

      # Original value of def red (replaced by the ansi_code_string method here):
      # color? ? ANSI::Code.red(string) : string
      # Output of "ANSI::Code.red('Hello')" in Rails console (require 'ansi'):
      #  => "\e[31mHello\e[0m"
      # Output of "puts ANSI::Code.red('Hello')":
      # Hello <in red>
      # Output of 'puts "\e[1;31mHello\e[0m"':
      # Hello <in bright red>
      def red(string)
        color? ? ansi_code_string(BRIGHT_RED, string) : string
      end

      def initialize(options = {})
        @rerun_user_prefix = options.fetch(:rerun_prefix, '')
        super
      end

      def report
        super

        puts

        unless @fast_fail
          # print rerun commands
          failed_or_error_tests = (tests.select { |t| t.failure && !t.skipped? })

          unless failed_or_error_tests.empty?
            puts red("You can rerun failed/error test by commands (you can add rerun prefix with 'rerun_prefix' option):")

            failed_or_error_tests.each do |test|
              print_rerun_command(test)
            end
          end
        end

        # summary for all suites again
        puts
        print colored_for(suite_result, result_line) # calls red(string), yellow(string), or green(string)
        puts
      end

      private

      def print_rerun_command(test)
        message = rerun_message_for(test)
        return if message.nil? || message.strip == ''

        puts
        puts colored_for(result(test), message)
      end

      def rerun_message_for(test)
        file_path = location(test.failure).gsub(/(:\d*)\z/, '')
        msg = "#{@rerun_user_prefix} rake test TEST=#{file_path} TESTOPTS=\"--name=#{test.name} -v\""
        if test.skipped?
          "Skipped: \n#{msg}"
        elsif test.error?
          "Error:\n#{msg}"
        else
          "Failure:\n#{msg}"
        end
      end

      def location(exception)
        last_before_assertion = ''

        exception.backtrace.reverse_each do |ss|
          break if ss =~ /in .(assert|refute|flunk|pass|fail|raise|must|wont)/

          last_before_assertion = ss
          break if ss =~ /_test.rb:/
        end

        last_before_assertion.sub(/:in .*$/, '')
      end
    end
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/MethodLength
