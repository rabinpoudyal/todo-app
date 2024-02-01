# frozen_string_literal: true

require 'typhoeus'
require 'todo/utils/number_generator'
require 'todo/constants'
require 'todo/integrations/response_handler'

module ToDo
  module Integrations
    class Requester
      include ToDo::NumberGenerator
      include ToDo::Component
      include ToDo::Integrations::ResponseHandler

      def initialize(config)
        @config = config
        @hydra = Typhoeus::Hydra.new
      end

      def fetch
        even_generator(@config[:count]).each do |even_number|
          request = Typhoeus::Request.new("#{BASE_URL}/#{even_number}")
          @hydra.queue(request)
          request.on_complete do |response|
            pretty_print(response)
          end
        end
        @hydra.run
      end
    end
  end
end
