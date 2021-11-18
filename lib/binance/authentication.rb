# frozen_string_literal: true

module Binance
  # Authentication response to API key and signature
  class Authentication
    attr_accessor :key, :secret

    def initialize(key, secret)
      @key = key
      @secret = secret
    end
  end
end
