# frozen_string_literal: true

module Binance
  class Spot
    # all wallet endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#wallet-endpoints
    module SimpleEarn

      # Account Status (System)
      #
      # GET /sapi/v1/system/status
      #
      # Fetch account status.
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#simple-account-user_data
      def simple_earn_account
        @session.public_request(path: '/sapi/v1/simple-earn/account')
      end

    
    end
  end
end
