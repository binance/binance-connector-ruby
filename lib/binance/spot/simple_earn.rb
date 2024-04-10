# frozen_string_literal: true

module Binance
  class Spot
    # all wallet endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#wallet-endpoints
    module SimpleEarn
      # Get Simple Earn Flexible Product List (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/list
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-simple-earn-flexible-product-list-user_data
      def flexible_product_list(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/list', params: kwargs)
      end

      # Get Simple Earn Locked Product List (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/list
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-simple-earn-locked-product-list-user_data
      def locked_product_list(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/list', params: kwargs)
      end

      # Subscribe Flexible Product (TRADE)
      #
      # POST /sapi/v1/simple-earn/flexible/subscribe
      #
      # @param productId [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Boolean] :autoSubscribe true or false, default true
      # @option kwargs [String] :sourceAccount SPOT,FUND,ALL, default SPOT
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#subscribe-flexible-product-trade
      def flexible_subscribe(productId:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/simple-earn/flexible/subscribe', params: kwargs.merge(
          productId: productId,
          amount: amount
        ))
      end

      # Subscribe Locked Product (TRADE)
      #
      # POST /sapi/v1/simple-earn/locked/subscribe
      #
      # @param projectId [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Boolean] :autoSubscribe true or false, default true
      # @option kwargs [String] :sourceAccount SPOT,FUND,ALL, default SPOT
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#subscribe-locked-product-trade
      def locked_subscribe(projectId:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('projectId', projectId)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/simple-earn/locked/subscribe', params: kwargs.merge(
          projectId: projectId,
          amount: amount
        ))
      end

      # Redeem Flexible Product (TRADE)
      #
      # POST /sapi/v1/simple-earn/flexible/redeem
      #
      # @param productId [String]
      # @param kwargs [Hash]
      # @option kwargs [Boolean] :redeemAll true or false, default true
      # @option kwargs [Float] :amount if redeemAll is false, amount is mandatory
      # @option kwargs [String] :destAccount SPOT,FUND,ALL, default SPOT
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#redeem-flexible-product-trade
      def flexible_redeem_product(productId:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)

        @session.sign_request(:post, '/sapi/v1/simple-earn/flexible/redeem', params: kwargs.merge(
          productId: productId
        ))
      end

      # Redeem Locked Product (TRADE)
      #
      # POST /sapi/v1/simple-earn/locked/redeem
      #
      # @param positionId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#redeem-locked-product-trade
      def locked_redeem_product(positionId:, **kwargs)
        Binance::Utils::Validation.require_param('positionId', positionId)

        @session.sign_request(:post, '/sapi/v1/simple-earn/locked/redeem', params: kwargs.merge(
          positionId: positionId
        ))
      end

      # Get Flexible Product Position (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/position
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :productId
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-product-position-user_data
      def flexible_product_position(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/position', params: kwargs)
      end

      # Get Locked Product Position (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/position
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :positionId
      # @option kwargs [String] :projectId
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-locked-product-position-user_data
      def locked_product_position(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/position', params: kwargs)
      end

      # Simple Account(USER_DATA)
      #
      # GET /sapi/v1/simple-earn/account'
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#simple-account-user_data
      def simple_earn_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/account', params: kwargs)
      end

      # Get Flexible Subscription Record (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/history/subscriptionRecord
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :productId
      # @option kwargs [String] :purchaseId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-subscription-record-user_data
      def flexible_subscription_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/history/subscriptionRecord', params: kwargs)
      end

      # Get Locked Subscription Record (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/history/subscriptionRecord
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :purchaseId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-locked-subscription-record-user_data
      def locked_subscription_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/history/subscriptionRecord', params: kwargs)
      end

      # Get Flexible Redemption Record (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/history/redemptionRecord
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :productId
      # @option kwargs [String] :redeemId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-redemption-record-user_data
      def flexible_redemption_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/history/redemptionRecord', params: kwargs)
      end

      # Get Locked Redemption Record (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/history/redemptionRecord
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :positionId
      # @option kwargs [String] :redeemId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-locked-redemption-record-user_data
      def locked_redemption_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/history/redemptionRecord', params: kwargs)
      end

      # Get Flexible Rewards History (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/history/rewardsRecord
      #
      # @param type [String] BONUS - Bonus tiered APR, REALTIME Real-time APR, REWARDS Historical rewards
      # @param kwargs [Hash]
      # @option kwargs [String] :productId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-rewards-history-user_data
      def flexible_rewards_history(type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/history/rewardsRecord', params: kwargs.merge(type: type))
      end

      # Get Locked Rewards History (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/history/rewardsRecord
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :positionId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-locked-rewards-history-user_data
      def locked_rewards_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/history/rewardsRecord', params: kwargs)
      end

      # Set Flexible Auto Subscribe (USER_DATA)
      #
      # POST /sapi/v1/simple-earn/flexible/setAutoSubscribe
      #
      # @param productId [String]
      # @param autoSubscribe [Boolean] true or false
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#set-flexible-auto-subscribe-user_data
      def flexible_auto_subscribe(productId:, autoSubscribe:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('autoSubscribe', autoSubscribe)

        @session.sign_request(:post, '/sapi/v1/simple-earn/flexible/setAutoSubscribe', params: kwargs.merge(
          productId: productId,
          autoSubscribe: autoSubscribe
        ))
      end

      # Set Locked Auto Subscribe (USER_DATA)
      #
      # POST /sapi/v1/simple-earn/locked/setAutoSubscribe
      #
      # @param positionId [String]
      # @param autoSubscribe [Boolean] true or false
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#set-locked-auto-subscribe-user_data
      def locked_auto_subscribe(positionId:, autoSubscribe:, **kwargs)
        Binance::Utils::Validation.require_param('positionId', positionId)
        Binance::Utils::Validation.require_param('autoSubscribe', autoSubscribe)

        @session.sign_request(:post, '/sapi/v1/simple-earn/locked/setAutoSubscribe', params: kwargs.merge(
          positionId: positionId,
          autoSubscribe: autoSubscribe
        ))
      end

      # Get Flexible Personal Left Quota (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/personalLeftQuota
      #
      # @param productId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-personal-left-quota-user_data
      def flexible_personal_left_quota(productId:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)

        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/personalLeftQuota', params: kwargs.merge(productId: productId))
      end

      # Get Locked Personal Left Quota (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/personalLeftQuota
      #
      # @param projectId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-locked-personal-left-quota-user_data
      def locked_personal_left_quota(projectId:, **kwargs)
        Binance::Utils::Validation.require_param('projectId', projectId)

        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/personalLeftQuota', params: kwargs.merge(projectId: projectId))
      end

      # Get Flexible Subscription Preview (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/subscriptionPreview
      #
      # @param productId [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-subscription-preview-user_data
      def flexible_subscription_preview(productId:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/subscriptionPreview', params: kwargs.merge(
          productId: productId,
          amount: amount
        ))
      end

      # Get Locked Subscription Preview (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/locked/subscriptionPreview
      #
      # @param projectId [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Boolean] :autoSubscribe true or false, default true
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-locked-subscription-preview-user_data
      def locked_subscription_preview(projectId:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('projectId', projectId)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:get, '/sapi/v1/simple-earn/locked/subscriptionPreview', params: kwargs.merge(
          projectId: projectId,
          amount: amount
        ))
      end

      # Get Rate History (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/history/rateHistory
      #
      # @param productId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-rate-history-user_data
      def rate_history(productId:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)

        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/history/rateHistory', params: kwargs.merge(productId: productId))
      end

      # Get Collateral Record (USER_DATA)
      #
      # GET /sapi/v1/simple-earn/flexible/history/collateralRecord
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :productId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying the page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-collateral-record-user_data
      def collateral_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/simple-earn/flexible/history/collateralRecord', params: kwargs)
      end
    end
  end
end
