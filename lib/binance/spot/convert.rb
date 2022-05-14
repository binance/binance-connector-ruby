# frozen_string_literal: true

module Binance
  class Spot
    # Convert endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#convert-endpoints
    module Convert
      # Get Convert Trade History (USER_DATA)
      #
      # GET /sapi/v1/convert/tradeFlow
      #
      # @param startTime [Integer]
      # @param endTime [Integer]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :limit default 100, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#convert-endpoints
      def convert_trade_flow(startTime:, endTime:, **kwargs)
        Binance::Utils::Validation.require_param('startTime', startTime)
        Binance::Utils::Validation.require_param('endTime', endTime)

        @session.sign_request(:get, '/sapi/v1/convert/tradeFlow', params: kwargs.merge(
          startTime: startTime,
          endTime: endTime
        ))
      end
    end
  end
end
