# frozen_string_literal: true

module Binance
  class Error < StandardError; end

  # Client error from 400 - 499
  class ClientError < Error
    attr_reader :response

    def initialize(response = nil)
      @response = response
      super(response)
    end
  end

  # Server side error for 5xx
  class ServerError < Error
  end

  # Error when missing required params
  class RequiredParameterError < Error
    def initialize(param_name, param_value)
      super(
        "ValidationFailed: #{param_name} is required, but provided value: #{param_value}"
      )
    end
  end

  # Error when Multi parameters are not allowed to send together
  class DuplicatedParametersError < Error
    def initialize(*kwargs)
      super("Parameters #{kwargs} should not be sent to server together.")
    end
  end
end
