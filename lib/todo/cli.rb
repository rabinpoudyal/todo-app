# frozen_string_literal: true

require 'optparse'
require 'singleton'

require_relative '../../src/todo.rb'

module ToDo # :nodoc:
  class CLI
    include Singleton
    
    def parse_options(argv)
      opts = {}
      @parser = option_parser(opts)
      @parser.parse!(argv)
      opts
    end

    def parse(args = ARGV.dup)
      setup_options(args)
    end

    def run
      ToDo.run(count: @config[:count], verbose: @config[:verbose])
    end

    def setup_options(args)
      @config = parse_options(args)
    end

    def option_parser(opts)
      parser = OptionParser.new do |o|

        o.on '-n', '--count COUNT', 'Number of items to process' do |arg|
          opts[:count] = Integer(arg)
        end

        o.on '-v', '--verbose', 'Print more verbose output' do |arg|
          opts[:verbose] = arg
        end

        o.on '-V', '--version', 'Print version and exit' do
          puts "Sidekiq #{ToDO::VERSION}"
          die(0)
        end
      end

      parser.banner = 'sidekiq [options]'
      parser.on_tail '-h', '--help', 'Show help' do
        logger.info parser
        die 1
      end

      parser
    end

    def initialize_logger
      @config.logger.level = ::Logger::DEBUG if @config[:verbose]
    end
  end
end
