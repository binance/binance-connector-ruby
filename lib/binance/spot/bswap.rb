# frozen_string_literal: true

module Binance
  class Spot
    # Bswap endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#bswap-endpoints
    module Bswap
      # List All Swap Pools (MARKET_DATA)
      #
      # GET /sapi/v1/bswap/pools
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#list-all-swap-pools-market_data
      def swap_pools
        @session.limit_request(path: '/sapi/v1/bswap/pools')
      end

      # Get liquidity information of a pool (USER_DATA)
      #
      # GET /sapi/v1/bswap/liquidity
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :poolId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-liquidity-information-of-a-pool-user_data
      def get_liquidity_info(**kwargs)
        @session.sign_request(:get, '/sapi/v1/bswap/liquidity', params: kwargs)
      end

      # Add Liquidity (TRADE)
      #
      # POST /sapi/v1/bswap/liquidityAdd
      #
      # @param poolId [Integer]
      # @param asset [String]
      # @param quantity [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :type "Single" to add a single token; "Combination" to add dual tokens. Default "Single"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#add-liquidity-trade
      def add_liquidity(poolId:, asset:, quantity:, **kwargs)
        Binance::Utils::Validation.require_param('poolId', poolId)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('quantity', quantity)

        @session.sign_request(:post, '/sapi/v1/bswap/liquidityAdd', params: kwargs.merge(
          poolId: poolId,
          asset: asset,
          quantity: quantity
        ))
      end

      # Remove Liquidity (TRADE)
      #
      # POST /sapi/v1/bswap/liquidityRemove
      #
      # @param poolId [Integer]
      # @param type [String] SINGLE for single asset removal, COMBINATION for combination of all coins removal
      # @param shareAmount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String Array] :asset Mandatory for single asset removal
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#remove-liquidity-trade
      def remove_liquidity(poolId:, type:, shareAmount:, **kwargs)
        Binance::Utils::Validation.require_param('poolId', poolId)
        Binance::Utils::Validation.require_param('type', type)
        Binance::Utils::Validation.require_param('shareAmount', shareAmount)

        @session.sign_request(:post, '/sapi/v1/bswap/liquidityRemove', params: kwargs.merge(
          poolId: poolId,
          type: type,
          shareAmount: shareAmount
        ))
      end

      # Get Liquidity Operation Record (USER_DATA)
      #
      # GET /sapi/v1/bswap/liquidityOps
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :operationId
      # @option kwargs [Integer] :poolId
      # @option kwargs [String] :operation ADD or REMOVE
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 3, max 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-liquidity-operation-record-user_data
      def get_liquidity_operation_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/bswap/liquidityOps', params: kwargs)
      end

      # Request Quote (USER_DATA)
      #
      # GET /sapi/v1/bswap/quote
      #
      # @param quoteAsset [String]
      # @param baseAsset [String]
      # @param quoteQty [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#request-quote-user_data
      def request_quote(quoteAsset:, baseAsset:, quoteQty:, **kwargs)
        Binance::Utils::Validation.require_param('quoteAsset', quoteAsset)
        Binance::Utils::Validation.require_param('baseAsset', baseAsset)
        Binance::Utils::Validation.require_param('quoteQty', quoteQty)

        @session.sign_request(:get, '/sapi/v1/bswap/quote', params: kwargs.merge(
          quoteAsset: quoteAsset,
          baseAsset: baseAsset,
          quoteQty: quoteQty
        ))
      end

      # Swap (TRADE)
      #
      # POST /sapi/v1/bswap/swap
      #
      # @param quoteAsset [String]
      # @param baseAsset [String]
      # @param quoteQty [Float]
      # @param [Hash] kwargs
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#swap-trade
      def swap(quoteAsset:, baseAsset:, quoteQty:, **kwargs)
        Binance::Utils::Validation.require_param('quoteAsset', quoteAsset)
        Binance::Utils::Validation.require_param('baseAsset', baseAsset)
        Binance::Utils::Validation.require_param('quoteQty', quoteQty)

        @session.sign_request(:post, '/sapi/v1/bswap/swap', params: kwargs.merge(
          quoteAsset: quoteAsset,
          baseAsset: baseAsset,
          quoteQty: quoteQty
        ))
      end

      # Get Swap History (USER_DATA)
      #
      # GET /sapi/v1/bswap/swap
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :swapId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :status 0: pending for swap, 1: success, 2: failed
      # @option kwargs [String] :quoteAsset
      # @option kwargs [String] :baseAsset
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-swap-history-user_data
      def get_swap_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/bswap/swap', params: kwargs)
      end

      # Get Pool Configure (USER_DATA)
      #
      # GET /sapi/v1/bswap/poolConfigure
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :poolId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-pool-configure-user_data
      def get_pool_config(**kwargs)
        @session.sign_request(:get, '/sapi/v1/bswap/poolConfigure', params: kwargs)
      end

      # Add Liquidity Preview (USER_DATA)
      #
      # GET /sapi/v1/bswap/addLiquidityPreview
      #
      # @param poolId [Integer]
      # @param type [String] "SINGLE" for adding a single token; "COMBINATION" for adding dual tokens
      # @param quoteAsset [String]
      # @param quoteQty [Float]
      # @param [Hash] kwargs
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#add-liquidity-preview-user_data
      def add_liquidity_preview(poolId:, type:, quoteAsset:, quoteQty:, **kwargs)
        Binance::Utils::Validation.require_param('poolId', poolId)
        Binance::Utils::Validation.require_param('type', type)
        Binance::Utils::Validation.require_param('quoteAsset', quoteAsset)
        Binance::Utils::Validation.require_param('quoteQty', quoteQty)

        @session.sign_request(:get, '/sapi/v1/bswap/addLiquidityPreview', params: kwargs.merge(
          poolId: poolId,
          type: type,
          quoteAsset: quoteAsset,
          quoteQty: quoteQty
        ))
      end

      # Remove Liquidity Preview (USER_DATA)
      #
      # GET /sapi/v1/bswap/removeLiquidityPreview
      #
      # @param poolId [Integer]
      # @param type [String] "SINGLE" for removing a single token; "COMBINATION" for removing dual tokens
      # @param quoteAsset [String]
      # @param shareAmount [Float]
      # @param [Hash] kwargs
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#remove-liquidity-preview-user_data
      def remove_liquidity_preview(poolId:, type:, quoteAsset:, shareAmount:, **kwargs)
        Binance::Utils::Validation.require_param('poolId', poolId)
        Binance::Utils::Validation.require_param('type', type)
        Binance::Utils::Validation.require_param('quoteAsset', quoteAsset)
        Binance::Utils::Validation.require_param('shareAmount', shareAmount)

        @session.sign_request(:get, '/sapi/v1/bswap/removeLiquidityPreview', params: kwargs.merge(
          poolId: poolId,
          type: type,
          quoteAsset: quoteAsset,
          shareAmount: shareAmount
        ))
      end
    end
  end
end
