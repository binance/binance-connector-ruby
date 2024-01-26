# frozen_string_literal: true

module Binance
  class Spot
    # all wallet endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#wallet-endpoints
    module SimpleEarn

      # All Coins' Information on 'simple earn' (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/account'
      #
      # Get information of coins (in simple earn) for user.
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#simple-account-user_data
      def simple_earn_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/account', params: kwargs)
      end
    
    end
  end
end
