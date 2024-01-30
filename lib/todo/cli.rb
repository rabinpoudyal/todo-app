# frozen_string_literal: true

require 'optparse'
require 'singleton'

require_relative '../../src/todo/version'
require_relative '../../src/todo'
require_relative '../todo/yaml'
require_relative './component'

module ToDo
  class CLI
    include Singleton
    include ToDo::Component

    def parse_options(argv)
      opts = {}
      @parser = option_parser(opts)
      @parser.parse!(argv)
      opts
    end

    def setup_options(args)
      default_config = Yaml.load('config.yml').transform_keys(&:to_sym)
      @config = parse_options(args)
      @config = default_config.merge(@config)
    end

    def option_parser(opts)
      parser = OptionParser.new do |o|
        o.on '-n', '--count COUNT', 'Number of todos to fetch' do |arg|
          opts[:count] = Integer(arg)
        end

        o.on '-v', '--verbose', 'Print more verbose output' do |arg|
          opts[:verbose] = arg
        end

        o.on '-V', '--version', 'Print app version and exit' do
          puts "ToDo App #{ToDoApp::VERSION}"
          exit(0)
        end
      end

      parser.banner = 'bin/todo [options]'
      parser.on_tail '-h', '--help', 'Show help' do
        puts parser.help
        exit(0)
      end

      parser
    end

    def initialize_logger
      @config.logger = ::Logger.new($stdout)
      @config.logger.level = ::Logger::DEBUG if @config[:verbose]
    end

    def parse(args = ARGV.dup)
      setup_options(args)
      initialize_logger
    end

    def run
      puts @config
      ToDo::App.new(@config).run(count: @config[:count], verbose: @config[:verbose])
    end
  end
end
