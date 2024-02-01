# frozen_string_literal: true

module ToDo
  module Component
    attr_reader :config

    def logger
      config.logger
    end
  end
end
