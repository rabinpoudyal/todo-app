# frozen_string_literal: true

require 'forwardable'

require 'todo/utils/logger'

module ToDo
  class Config
    extend Forwardable

    DEFAULTS = {
      logger: nil,
      count: 10,
      verbose: false
    }.freeze

    def initialize(options = {})
      @options = DEFAULTS.merge(options)
    end

    def_delegators :@options, :[], :[]=, :fetch, :key?, :has_key?, :merge!
    attr_accessor :options

    def logger
      @logger ||= ToDo::Logger.new($stdout, level: :info).tap do |log|
        log.level = Logger::INFO
      end
    end

    def logger=(logger)
      if logger.nil?
        self.logger.level = Logger::FATAL
        return
      end

      @logger = logger
    end
  end
end
