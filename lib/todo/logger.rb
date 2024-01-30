# frozen_string_literal: true

class ToDoLogger < Logger
  def initialize
    super($stdout)
    self.level = Logger::INFO
    self.formatter = proc do |_severity, _datetime, _progname, msg|
      "#{msg}\n"
    end
  end
end
