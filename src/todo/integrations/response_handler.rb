# frozen_string_literal: true

require 'colorize'
require 'oj'

module ToDo
  module Integrations
    module ResponseHandler
      def pretty_print(response)
        if response.success?
          parsed_response = Oj.load(response.body)
          if parsed_response['completed']
            puts " ✔ #{parsed_response['title']}".green
          else
            puts " ✘ #{parsed_response['title']}".red
          end
        elsif response.timed_out?
          puts 'got a time out'
        elsif response.code.zero?
          puts response.return_message
        else
          puts "HTTP request failed: #{response.code}"
        end
      end
    end
  end
end
