# frozen_string_literal: true

require 'logger'

LEVELS = {
  'debug' => 0,
  'info' => 1,
  'warn' => 2,
  'error' => 3,
  'fatal' => 4
}.freeze

class Logger < ::Logger
  def initialize(logdev, shift_age = 0, shift_size = 1_048_576, level: DEBUG)
    super(logdev, shift_age, shift_size)
    self.level = level
  end

  def level=(level)
    super(LEVELS[level])
  end

  def log(severity, message = nil, progname = nil)
    super(severity, message, progname) if LEVELS[severity] >= LEVELS[level]
  end
end
