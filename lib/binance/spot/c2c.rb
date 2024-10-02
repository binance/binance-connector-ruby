# frozen_string_literal: true

module Binance
  class Spot
    # C2C endpoints
    # @see https://developers.binance.com/docs/c2c/Introduction
    module C2C
      # Get C2C Trade History (USER_DATA)
      #
      # GET /sapi/v1/c2c/orderMatch/listUserOrderHistory
      #
      # @param tradeType [String]
      # @option kwargs [Integer] :startTimestamp
      # @option kwargs [Integer] :endTimestamp
      # @option kwargs [Integer] :page
      # @option kwargs [Integer] :rows
      # @option kwargs [Integer] :recvWindow
      # @option kwargs [Integer] :timestamp
      # @see https://developers.binance.com/docs/c2c/rest-api/Get-C2C-Trade-History
      def c2c_trade_history(tradeType:, **kwargs)
        Binance::Utils::Validation.require_param('tradeType', tradeType)

        @session.sign_request(:get, '/sapi/v1/c2c/orderMatch/listUserOrderHistory', params: kwargs.merge(tradeType: tradeType))
      end
    end
  end
end
