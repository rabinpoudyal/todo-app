# frozen_string_literal: true

require 'typhoeus'
require 'oj'
require 'colorize'

require_relative './constants'
require_relative './todo/version'
require_relative '../lib/todo/component'

module ToDo
  class App
    include ToDo::Component

    def initialize(config)
      @config = config
    end

    def even_numbers_generator(n)
      (1..Float::INFINITY)
        .lazy
        .select(&:even?)
        .take(n)
    end

    def run(count: 10, verbose: false)
      logger.log "Running ToDo v#{ToDoApp::VERSION} with count: #{count}"
      hydra = Typhoeus::Hydra.new

      even_numbers_generator(count).each do |even_number|
        request = Typhoeus::Request.new("#{BASE_URL}/#{even_number}")
        hydra.queue(request)
        request.on_complete do |response|
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
      hydra.run
    end
  end
end
