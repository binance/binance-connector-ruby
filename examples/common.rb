# frozen_string_literal: true

# common module for examples
module Common
  class << self
    def setup_logger
      require 'logger'
      logger = Logger.new($stdout)
      logger.level = Logger::INFO
      logger
    end
  end
end
