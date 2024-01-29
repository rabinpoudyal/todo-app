# frozen_string_literal: true

require 'optparse'
require 'singleton'

require_relative '../../src/todo/version'
require_relative '../../src/todo'
require_relative '../todo/yaml'

module ToDo
  class CLI
    include Singleton

    def parse_options(argv)
      opts = {}
      @parser = option_parser(opts)
      @parser.parse!(argv)
      opts
    end

    def setup_options(args)
      default_config = ToDo::Yaml.load(File.join(__dir__, 'config.yml'))
      @logger = Logger.new($stdout)
      @config = parse_options(args)
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
        @logger.info parser.help
        exit(0)
      end

      parser
    end

    def initialize_logger
      @config.logger.level = ::Logger::DEBUG if @config[:verbose]
    end

    def parse(args = ARGV.dup)
      setup_options(args)
      initialize_logger
    end

    def run
      puts @config
      ToDo.run(count: @config[:count], verbose: @config[:verbose])
    end
  end
end
