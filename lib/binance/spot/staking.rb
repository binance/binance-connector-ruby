# frozen_string_literal: true

module Binance
  class Spot
    # all savings endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#savings-endpoints
    module Staking
      # Get Staking Product List(USER_DATA)
      #
      # GET /sapi/v1/staking/productList
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :current
      # @option kwargs [Integer] :size
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-staking-product-list-user_data
      def staking_product_list(product:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)

        @session.sign_request(:get, '/sapi/v1/staking/productList', params: kwargs.merge(product: product))
      end

      # Purchase Staking Product(USER_DATA)
      #
      # POST /sapi/v1/staking/purchase
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param productId [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :renewable
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#purchase-staking-product-user_data
      def staking_purchase(product:, productId:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/staking/purchase', params: kwargs.merge(product: product, productId: productId, amount: amount))
      end

      # Redeem Staking Product(USER_DATA)
      #
      # POST /sapi/v1/staking/redeem
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param productId [String]
      # @param kwargs [Hash]
      # @option kwargs [Float] :amount
      # @option kwargs [String] :positionId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#redeem-staking-product-user_data
      def staking_redeem(product:, productId:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)
        Binance::Utils::Validation.require_param('productId', productId)

        @session.sign_request(:post, '/sapi/v1/staking/redeem', params: kwargs.merge(product: product, productId: productId))
      end

      # Get Staking Product Position(USER_DATA)
      #
      # GET /sapi/v1/staking/position
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param kwargs [Hash]
      # @option kwargs [String] :productId
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :current
      # @option kwargs [Integer] :size
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-staking-product-list-user_data
      def staking_position(product:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)

        @session.sign_request(:get, '/sapi/v1/staking/position', params: kwargs.merge(product: product))
      end

      # Get Staking History(USER_DATA)
      #
      # GET /sapi/v1/staking/stakingRecord
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param txnType [String] "SUBSCRIPTION", "REDEMPTION", "INTEREST"
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current
      # @option kwargs [Integer] :size
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-staking-history-user_data
      def staking_history(product:, txnType:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)
        Binance::Utils::Validation.require_param('txnType', txnType)

        @session.sign_request(:get, '/sapi/v1/staking/stakingRecord', params: kwargs.merge(product: product, txnType: txnType))
      end

      # Set Auto Staking(USER_DATA)
      #
      # POST /sapi/v1/staking/setAutoStaking
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param positionId [String]
      # @param renewable [String]  true or false
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#set-auto-staking-user_data
      def staking_set_auto(product:, positionId:, renewable:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)
        Binance::Utils::Validation.require_param('positionId', positionId)
        Binance::Utils::Validation.require_param('renewable', renewable)

        @session.sign_request(:post, '/sapi/v1/staking/setAutoStaking', params: kwargs.merge(product: product, positionId: positionId, renewable: renewable))
      end

      # Get Personal Left Quota of Staking Product(USER_DATA)
      #
      # GET /sapi/v1/staking/personalLeftQuota
      #
      # @param product [String] "STAKING" for Locked Staking, "F_DEFI" for flexible DeFi Staking, "L_DEFI" for locked DeFi Staking
      # @param productId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-staking-history-user_data
      def staking_personal_quota_remain(product:, productId:, **kwargs)
        Binance::Utils::Validation.require_param('product', product)
        Binance::Utils::Validation.require_param('productId', productId)

        @session.sign_request(:get, '/sapi/v1/staking/personalLeftQuota', params: kwargs.merge(product: product, productId: productId))
      end
    end
  end
end
