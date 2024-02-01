# frozen_string_literal: true

require 'optparse'
require 'singleton'

require 'todo'
require 'todo/version'
require 'todo/parsers/yaml'
require 'todo/component'
require 'todo/launcher'

module ToDo
  class CLI
    include Singleton
    include ToDo::Component

    attr_accessor :config

    def parse(args = ARGV.dup)
      @config ||= ToDo.default_configuration
      setup_options(args)
      initialize_logger
    end

    def parse_options(argv)
      opts = {}
      @parser = option_parser(opts)
      @parser.parse!(argv)
      opts
    end

    def setup_options(args)
      ops = parse_options(args)
      @config.merge!(ops)
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
      @config.logger.level = ::Logger::DEBUG if @config[:verbose]
    end

    def run
      launch
    end

    def launch
      @launcher = ToDo::Launcher.new(@config)
      @launcher.launch
    end
  end
end
