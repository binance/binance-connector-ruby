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
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param tokenName [String]
      # @param cost [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#subscribe-blvt-user_data
      def subscribe(timestamp = present_timestamp, tokenName:, cost:, **kwargs)
        Binance::Utils::Validation.require_param('tokenName', tokenName)
        Binance::Utils::Validation.require_param('cost', cost)

        @session.sign_request(:post, '/sapi/v1/blvt/subscribe', timestamp, params: kwargs.merge(
          tokenName: tokenName,
          cost: cost
        ))
      end

      # Query Subscription Record (USER_DATA)
      #
      # GET /sapi/v1/blvt/subscribe/record
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :tokenName
      # @option kwargs [Integer] :id
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-subscription-record-user_data
      def get_subscribe_record(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/blvt/subscribe/record', timestamp, params: kwargs)
      end

      # Redeem BLVT (USER_DATA)
      #
      # POST /sapi/v1/blvt/redeem
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param tokenName [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#redeem-blvt-user_data
      def redeem(timestamp = present_timestamp, tokenName:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('tokenName', tokenName)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/blvt/redeem', timestamp, params: kwargs.merge(
          tokenName: tokenName,
          amount: amount
        ))
      end

      # Query Redemption Record (USER_DATA)
      #
      # GET /sapi/v1/blvt/redeem/record
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :tokenName
      # @option kwargs [Integer] :id
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-redemption-record-user_data
      def get_redeem_record(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/blvt/redeem/record', timestamp, params: kwargs)
      end

      # Get BLVT User Limit Info (USER_DATA)
      #
      # GET /sapi/v1/blvt/userLimit
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :tokenName
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-blvt-user-limit-info-user_data
      def user_limit(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/blvt/userLimit', timestamp, params: kwargs)
      end
    end
  end
end
