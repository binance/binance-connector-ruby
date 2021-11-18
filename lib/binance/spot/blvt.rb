# frozen_string_literal: true

module Binance
  class Spot
    # BLVT endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#blvt-endpoints
    module Blvt
      # Get BLVT Info (MARKET_DATA)
      #
      # GET /sapi/v1/blvt/tokenInfo
      #
      # @param tokenName [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-blvt-info-market_data
      def token_info(tokenName: nil)
        @session.public_request(
          path: '/sapi/v1/blvt/tokenInfo',
          params: { tokenName: tokenName }
        )
      end

      # Subscribe BLVT (USER_DATA)
      #
      # POST /sapi/v1/blvt/subscribe
      #
      # @param tokenName [String]
      # @param cost [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#subscribe-blvt-user_data
      def subscribe(tokenName:, cost:, **kwargs)
        Binance::Utils::Validation.require_param('tokenName', tokenName)
        Binance::Utils::Validation.require_param('cost', cost)

        @session.sign_request(:post, '/sapi/v1/blvt/subscribe', params: kwargs.merge(
          tokenName: tokenName,
          cost: cost
        ))
      end

      # Query Subscription Record (USER_DATA)
      #
      # GET /sapi/v1/blvt/subscribe/record
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :tokenName
      # @option kwargs [Integer] :id
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-subscription-record-user_data
      def get_subscribe_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/blvt/subscribe/record', params: kwargs)
      end

      # Redeem BLVT (USER_DATA)
      #
      # POST /sapi/v1/blvt/redeem
      #
      # @param tokenName [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#redeem-blvt-user_data
      def redeem(tokenName:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('tokenName', tokenName)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/blvt/redeem', params: kwargs.merge(
          tokenName: tokenName,
          amount: amount
        ))
      end

      # Query Redemption Record (USER_DATA)
      #
      # GET /sapi/v1/blvt/redeem/record
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :tokenName
      # @option kwargs [Integer] :id
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-redemption-record-user_data
      def get_redeem_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/blvt/redeem/record', params: kwargs)
      end

      # Get BLVT User Limit Info (USER_DATA)
      #
      # GET /sapi/v1/blvt/userLimit
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :tokenName
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-blvt-user-limit-info-user_data
      def user_limit(**kwargs)
        @session.sign_request(:get, '/sapi/v1/blvt/userLimit', params: kwargs)
      end
    end
  end
end
