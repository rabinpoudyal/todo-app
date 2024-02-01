# frozen_string_literal: true

require 'todo/integrations/requester'

module ToDo
  class Launcher
    def initialize(config)
      @config = config
      @requester = ToDo::Integrations::Requester.new(@config)
    end

    def launch
      @requester.fetch
    end
  end
end
