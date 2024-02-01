# frozen_string_literal: true

require 'todo/defaults/config'

module ToDo
  # This is the main entry point for the ToDo application.
  # Define the top level methods required to launch the app here.

  def self.default_configuration
    @default_configuration ||= ToDo::Config.new
  end
end
