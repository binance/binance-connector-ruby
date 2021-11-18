# frozen_string_literal: true

module Binance
  class Spot
    # all savings endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#savings-endpoints
    module Savings
      # Get Flexible Product List (USER_DATA)
      #
      # GET /sapi/v1/lending/daily/product/list
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :status "ALL", "SUBSCRIBABLE", "UNSUBSCRIBABLE"; Default: "ALL"
      # @option kwargs [String] :featured "ALL", "TRUE"; Default: "ALL"
      # @option kwargs [Integer] :current Current query page. Default: 1, Min: 1
      # @option kwargs [Integer] :size Default: 50, Max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-product-list-user_data
      def savings_flexible_products(**kwargs)
        @session.sign_request(:get, '/sapi/v1/lending/daily/product/list', params: kwargs)
      end

      # Get Left Daily Purchase Quota of Flexible Product (USER_DATA)
      #
      # GET /sapi/v1/lending/daily/userLeftQuota
      #
      # @param productId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-left-daily-purchase-quota-of-flexible-product-user_data
      def savings_flexible_user_left_quota(productId:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)

        @session.sign_request(:get, '/sapi/v1/lending/daily/userLeftQuota', params: kwargs.merge(
          productId: productId
        ))
      end

      # Purchase Flexible Product (USER_DATA)
      #
      # POST /sapi/v1/lending/daily/purchase
      #
      # @param productId [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#purchase-flexible-product-user_data
      def savings_purchase_flexible_product(productId:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/lending/daily/purchase', params: kwargs.merge(
          productId: productId,
          amount: amount
        ))
      end

      # Get Left Daily Redemption Quota of Flexible Product (USER_DATA)
      #
      # GET /sapi/v1/lending/daily/userRedemptionQuota
      #
      # @param productId [String]
      # @param type [String] "FAST", "NORMAL"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-left-daily-redemption-quota-of-flexible-product-user_data
      def savings_flexible_user_redemption_quota(productId:, type:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/lending/daily/userRedemptionQuota', params: kwargs.merge(
          productId: productId,
          type: type
        ))
      end

      # Redeem Flexible Product (USER_DATA)
      #
      # POST /sapi/v1/lending/daily/redeem
      #
      # @param productId [String]
      # @param amount [Float]]
      # @param type [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#redeem-flexible-product-user_data
      def savings_flexible_redeem(productId:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('productId', productId)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/lending/daily/redeem', params: kwargs.merge(
          productId: productId,
          amount: amount,
          type: type
        ))
      end

      # Get Flexible Product Position (USER_DATA)
      #
      # GET /sapi/v1/lending/daily/token/position
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-flexible-product-position-user_data
      def savings_flexible_product_position(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/lending/daily/token/position', params: kwargs.merge(
          asset: asset
        ))
      end

      # Get Fixed and Activity Project List(USER_DATA)
      #
      # GET /sapi/v1/lending/project/list
      #
      # @param type [String] "REGULAR", "CUSTOMIZED_FIXED"
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :status "ALL", "SUBSCRIBABLE", "UNSUBSCRIBABLE"; default "ALL"
      # @option kwargs [Boolean] :isSortAsc default "true"
      # @option kwargs [String] :sortBy "START_TIME", "LOT_SIZE", "INTEREST_RATE", "DURATION"; default "START_TIME"
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10, Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-fixed-and-activity-project-list-user_data
      def savings_product_list(type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/lending/project/list', params: kwargs.merge(
          type: type
        ))
      end

      # Purchase Fixed/Activity Project (USER_DATA)
      #
      # POST /sapi/v1/lending/customizedFixed/purchase
      #
      # @param projectId [String]
      # @param lot [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#purchase-fixed-activity-project-user_data
      def savings_purchase_customized_project(projectId:, lot:, **kwargs)
        Binance::Utils::Validation.require_param('projectId', projectId)
        Binance::Utils::Validation.require_param('lot', lot)

        @session.sign_request(:post, '/sapi/v1/lending/customizedFixed/purchase', params: kwargs.merge(
          projectId: projectId,
          lot: lot
        ))
      end

      # Get Fixed/Activity Project Position (USER_DATA)
      #
      # GET /sapi/v1/lending/project/position/list
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :projectId
      # @option kwargs [String] :status "HOLDING", "REDEEMED"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-fixed-activity-project-position-user_data
      def savings_customized_position(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/lending/project/position/list', params: kwargs.merge(
          asset: asset
        ))
      end

      # Lending Account (USER_DATA)
      #
      # GET /sapi/v1/lending/union/account
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#lending-account-user_data
      def savings_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/lending/union/account', params: kwargs)
      end

      # Get Purchase Record (USER_DATA)
      #
      # GET /sapi/v1/lending/union/purchaseRecord
      #
      # @param lendingType [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current
      # @option kwargs [Integer] :size
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-purchase-record-user_data
      def savings_purchase_record(lendingType:, **kwargs)
        Binance::Utils::Validation.require_param('lendingType', lendingType)

        @session.sign_request(:get, '/sapi/v1/lending/union/purchaseRecord', params: kwargs.merge(
          lendingType: lendingType
        ))
      end

      # Get Redemption Record (USER_DATA)
      #
      # GET /sapi/v1/lending/union/redemptionRecord
      #
      # @param lendingType [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current
      # @option kwargs [Integer] :size
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-redemption-record-user_data
      def savings_redemption_record(lendingType:, **kwargs)
        Binance::Utils::Validation.require_param('lendingType', lendingType)

        @session.sign_request(:get, '/sapi/v1/lending/union/redemptionRecord', params: kwargs.merge(
          lendingType: lendingType
        ))
      end

      # Get Interest History (USER_DATA)
      #
      # GET /sapi/v1/lending/union/interestHistory
      #
      # @param lendingType [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current
      # @option kwargs [Integer] :size
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-interest-history-user_data-2
      def savings_interest_history(lendingType:, **kwargs)
        Binance::Utils::Validation.require_param('lendingType', lendingType)

        @session.sign_request(:get, '/sapi/v1/lending/union/interestHistory', params: kwargs.merge(
          lendingType: lendingType
        ))
      end

      # Change Fixed/Activity Position to Daily Position(USER_DATA)
      #
      # POST /sapi/v1/lending/positionChanged
      #
      # @param projectId [String]
      # @param lot [Integer]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :positionId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#change-fixed-activity-position-to-daily-position-user_data
      def savings_position_changed(projectId:, lot:, **kwargs)
        Binance::Utils::Validation.require_param('projectId', projectId)
        Binance::Utils::Validation.require_param('lot', lot)

        @session.sign_request(:post, '/sapi/v1/lending/positionChanged', params: kwargs.merge(
          projectId: projectId,
          lot: lot
        ))
      end
    end
  end
end
