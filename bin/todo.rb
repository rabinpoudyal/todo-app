#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../src', __dir__)

require 'todo/interfaces/cli'

begin
  cli = ToDo::CLI.instance
  cli.parse

  cli.run
rescue StandardError => e
  raise e if $DEBUG

  warn e.message
  warn e.backtrace.join("\n")
  exit 1
end
