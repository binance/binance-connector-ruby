# frozen_string_literal: true

module Binance
  class Spot
    # Margin endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-trade
    module Margin
      # Cross Margin Account Transfer (MARGIN)
      #
      # POST /sapi/v1/margin/transfer
      #
      # Execute transfer between spot account and cross margin account.
      #
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-margin-account-transfer-margin
      def margin_transfer(asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/margin/transfer', params: kwargs.merge(
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Margin Account Borrow (MARGIN)
      #
      # POST /sapi/v1/margin/loan
      #
      # Apply for a loan.
      #
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE"; default "FALSE"
      # @option kwargs [String] :symbol isolated symbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-borrow-margin
      def margin_borrow(asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/margin/loan', params: kwargs.merge(
          asset: asset,
          amount: amount
        ))
      end

      # Margin Account Repay (MARGIN)
      #
      # POST /sapi/v1/margin/repay
      #
      # Repay loan for margin account.
      #
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE"; default "FALSE"
      # @option kwargs [String] :symbol isolated symbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-repay-margin
      def margin_repay(asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/margin/repay', params: kwargs.merge(
          asset: asset,
          amount: amount
        ))
      end

      # Query Margin Asset (MARKET_DATA)
      #
      # GET /sapi/v1/margin/asset
      #
      # @param asset [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-asset-market_data
      def margin_asset(asset:)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.limit_request(path: '/sapi/v1/margin/asset', params: { asset: asset })
      end

      # Query Margin Pair (MARKET_DATA)
      #
      # GET /sapi/v1/margin/pair
      #
      # @param symbol [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-pair-market_data
      def margin_pair(symbol:)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.limit_request(path: '/sapi/v1/margin/pair', params: { symbol: symbol })
      end

      # Get All Margin Assets (MARKET_DATA)
      #
      # GET /sapi/v1/margin/allAssets
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-all-margin-assets-market_data
      def margin_all_assets
        @session.limit_request(path: '/sapi/v1/margin/allAssets')
      end

      # Get All Margin Pairs (MARKET_DATA)
      #
      # GET /sapi/v1/margin/allPairs
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-all-margin-pairs-market_data
      def margin_all_pairs
        @session.limit_request(path: '/sapi/v1/margin/allPairs')
      end

      # Query Margin PriceIndex (MARKET_DATA)
      #
      # GET /sapi/v1/margin/priceIndex
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-priceindex-market_data
      def margin_price_index(symbol:)
        Binance::Utils::Validation.require_param('symbol', symbol)
        @session.limit_request(path: '/sapi/v1/margin/priceIndex', params: { symbol: symbol })
      end

      # Margin Account New Order (TRADE)
      #
      # POST /sapi/v1/margin/order
      #
      # @param symbol [String]
      # @param side [String]
      # @param type [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Float] :quantity
      # @option kwargs [Float] :quoteOrderQty
      # @option kwargs [Float] :price
      # @option kwargs [Float] :stopPrice Used with STOP_LOSS, STOP_LOSS_LIMIT, TAKE_PROFIT, and TAKE_PROFIT_LIMIT orders.
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Float] :icebergQty Used with LIMIT, STOP_LOSS_LIMIT, and TAKE_PROFIT_LIMIT to create an iceberg order.
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [String] :sideEffectType NO_SIDE_EFFECT, MARGIN_BUY, AUTO_REPAY; default NO_SIDE_EFFECT.
      # @option kwargs [String] :timeInForce GTC,IOC,FOK
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-new-order-trade
      def margin_new_order(symbol:, side:, type:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/margin/order', params: kwargs.merge(
          symbol: symbol,
          side: side,
          type: type
        ))
      end

      # Margin Account Cancel Order (TRADE)
      #
      # DELETE /sapi/v1/margin/order
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [String] :orderId
      # @option kwargs [String] :origClientOrderId
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-new-order-trade
      def margin_cancel_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/order', params: kwargs.merge(
          symbol: symbol
        ))
      end

      # Margin Account Cancel all Open Orders on a Symbol (TRADE)
      #
      # DELETE /sapi/v1/margin/openOrders
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-cancel-all-open-orders-on-a-symbol-trade
      def margin_cancel_all_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/openOrders', params: kwargs.merge(
          symbol: symbol
        ))
      end

      # Get Cross Margin Transfer History (USER_DATA)
      #
      # GET /sapi/v1/margin/transfer
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :type
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [String] :archived Default: false. Set to true for archived data from 6 months ago
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-cross-margin-transfer-history-user_data
      def margin_transfer_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/transfer', params: kwargs)
      end

      # Query Loan Record (USER_DATA)
      #
      # GET /sapi/v1/margin/loan
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [String] :txId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [String] :archived Default: false. Set to true for archived data from 6 months ago
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-loan-record-user_data
      def margin_load_record(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/loan', params: kwargs.merge(asset: asset))
      end

      # Query Repay Record (USER_DATA)
      #
      # GET /sapi/v1/margin/repay
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [String] :txId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [String] :archived Default: false. Set to true for archived data from 6 months ago
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-repay-record-user_data
      def margin_repay_record(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/repay', params: kwargs.merge(asset: asset))
      end

      # Get Interest History (USER_DATA)
      #
      # GET /sapi/v1/margin/interestHistory
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [String] :archived Default: false. Set to true for archived data from 6 months ago
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-interest-history-user_data
      def margin_interest_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/interestHistory', params: kwargs)
      end

      # Get Force Liquidation Record (USER_DATA)
      #
      # GET /sapi/v1/margin/forceLiquidationRec
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-force-liquidation-record-user_data
      def margin_force_liquidation_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/forceLiquidationRec', params: kwargs)
      end

      # Query Cross Margin Account Details (USER_DATA)
      #
      # GET /sapi/v1/margin/account
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-cross-margin-account-details-user_data
      def margin_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/account', params: kwargs)
      end

      # Query Margin Account's Order (USER_DATA)
      #
      # GET /sapi/v1/margin/order
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Integer] :orderId
      # @option kwargs [String] :origClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-order-user_data
      def margin_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/order', params: kwargs.merge(symbol: symbol))
      end

      # Query Margin Account's Open Order (USER_DATA)
      #
      # GET /sapi/v1/margin/openOrders
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-open-orders-user_data
      def margin_open_orders(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/openOrders', params: kwargs)
      end

      # Query Margin Account's All Order (USER_DATA)
      #
      # GET /sapi/v1/margin/allOrders
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [String] :orderId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-all-orders-user_data
      def margin_all_orders(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/allOrders', params: kwargs.merge(symbol: symbol))
      end

      # Margin Account New OCO (TRADE)
      #
      # POST /sapi/v1/margin/order/oco
      #
      # @param symbol [String]
      # @param side [String]
      # @param quantity [Float]
      # @param price [Float]
      # @param stopPrice [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated for isolated margin or not, "TRUE", "FALSE", default "FALSE"
      # @option kwargs [String] :listClientOrderId
      # @option kwargs [String] :limitClientOrderId
      # @option kwargs [Float] :limitIcebergQty
      # @option kwargs [String] :stopClientOrderId
      # @option kwargs [Float] :stopLimitPrice If provided, stopLimitTimeInForce is required.
      # @option kwargs [Float] :stopIcebergQty
      # @option kwargs [String] :stopLimitTimeInForce Valid values are GTC/FOK/IOC
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [String] :sideEffectType NO_SIDE_EFFECT, MARGIN_BUY, AUTO_REPAY; default NO_SIDE_EFFECT.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-new-oco-trade
      def margin_oco_order(symbol:, side:, quantity:, price:, stopPrice:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('quantity', quantity)
        Binance::Utils::Validation.require_param('price', price)
        Binance::Utils::Validation.require_param('stopPrice', stopPrice)

        @session.sign_request(:post, '/sapi/v1/margin/order/oco', params: kwargs.merge(
          symbol: symbol,
          side: side,
          quantity: quantity,
          price: price,
          stopPrice: stopPrice
        ))
      end

      # Margin Account Cancel OCO (TRADE)
      #
      # DELETE /sapi/v1/margin/orderList
      #
      # Canceling an individual leg will cancel the entire OCO
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :orderListId Either orderListId or listClientOrderId must be provided
      # @option kwargs [String] :listClientOrderId Either orderListId or listClientOrderId must be provided
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-account-cancel-oco-trade
      def margin_cancel_oco(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/orderList', params: kwargs.merge(
          symbol: symbol
        ))
      end

      # Query Margin Account's OCO (USER_DATA)
      #
      # GET /sapi/v1/margin/orderList
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :orderListId Either orderListId or origClientOrderId must be provided
      # @option kwargs [String] :origClientOrderId Either orderListId or origClientOrderId must be provided
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-oco-user_data
      def margin_get_oco(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/orderList', params: kwargs)
      end

      # Query Margin Account's all OCO (USER_DATA)
      #
      # GET /sapi/v1/margin/allOrderList
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :fromId If supplied, neither startTime nor endTime can be provided
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-all-oco-user_data
      def margin_get_all_oco(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/allOrderList', params: kwargs)
      end

      # Query Margin Account's Open OCO (USER_DATA)
      #
      # GET /sapi/v1/margin/openOrderList
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [String] :isIsolated
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-open-oco-user_data
      def margin_get_open_oco(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/openOrderList', params: kwargs)
      end

      # Query Margin Account's Trade List (USER_DATA)
      #
      # GET /sapi/v1/margin/myTrades
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [String] :orderfromIdId
      # @option kwargs [Integer] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-account-39-s-trade-list-user_data
      def margin_my_trades(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/myTrades', params: kwargs.merge(symbol: symbol))
      end

      # Query Max Borrow (USER_DATA)
      #
      # GET /sapi/v1/margin/maxBorrowable
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-max-borrow-user_data
      def margin_max_borrowable(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/maxBorrowable', params: kwargs.merge(asset: asset))
      end

      # Query Max Transfer-Out Amount (USER_DATA)
      #
      # GET /sapi/v1/margin/maxTransferable
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :isolatedSymbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-max-transfer-out-amount-user_data
      def margin_max_transferable(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/maxTransferable', params: kwargs.merge(asset: asset))
      end

      # Isolated Margin Account Transfer (MARGIN)
      #
      # POST /sapi/v1/margin/isolated/transfer
      #
      # @param asset [String]
      # @param symbol [String]
      # @param transFrom [String] "SPOT", "ISOLATED_MARGIN"
      # @param transTo [String] "SPOT", "ISOLATED_MARGIN"
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#isolated-margin-account-transfer-margin
      def isolated_margin_transfer(asset:, symbol:, transFrom:, transTo:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('transFrom', transFrom)
        Binance::Utils::Validation.require_param('transTo', transTo)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/margin/isolated/transfer', params: kwargs.merge(
          asset: asset,
          symbol: symbol,
          transFrom: transFrom,
          transTo: transTo,
          amount: amount
        ))
      end

      # Get Isolated Margin Transfer History (USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/transfer
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :transFrom "SPOT", "ISOLATED_MARGIN"
      # @option kwargs [String] :transTo "SPOT", "ISOLATED_MARGIN"
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current page, default 1
      # @option kwargs [Integer] :size Default 10, max 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-isolated-margin-transfer-history-user_data
      def get_isolated_margin_transfer(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/isolated/transfer', params: kwargs.merge(symbol: symbol))
      end

      # Query Isolated Margin Account Info (USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/account
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbols Max 5 symbols can be sent; separated by ",". e.g. "BTCUSDT,BNBUSDT,ADAUSDT"
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-isolated-margin-account-info-user_data
      def get_isolated_margin_account(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolated/account', params: kwargs)
      end

      # Disable Isolated Margin Account (TRADE)
      #
      # DELETE /sapi/v1/margin/isolated/account
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#disable-isolated-margin-account-trade
      def disable_isolated_margin_account(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/sapi/v1/margin/isolated/account', params: kwargs.merge(symbol: symbol))
      end

      # Enable Isolated Margin Account (TRADE)
      #
      # POST /sapi/v1/margin/isolated/account
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#enable-isolated-margin-account-trade
      def enable_isolated_margin_account(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:post, '/sapi/v1/margin/isolated/account', params: kwargs.merge(symbol: symbol))
      end

      # Query Enabled Isolated Margin Account Limit (USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/accountLimit
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-enabled-isolated-margin-account-limit-user_data
      def get_isolated_margin_account_limit(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolated/accountLimit', params: kwargs)
      end

      # Query Isolated Margin Symbol (USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/pair
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-isolated-margin-symbol-user_data
      def get_isolated_margin_pair(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/sapi/v1/margin/isolated/pair', params: kwargs.merge(symbol: symbol))
      end

      # Get All Isolated Margin Symbol(USER_DATA)
      #
      # GET /sapi/v1/margin/isolated/allPairs
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-all-isolated-margin-symbol-user_data
      def get_all_isolated_margin_pairs(**kwargs)
        @session.sign_request(:get, '/sapi/v1/margin/isolated/allPairs', params: kwargs)
      end

      # Toggle BNB Burn On Spot Trade And Margin Interest (USER_DATA)
      #
      # POST /sapi/v1/bnbBurn
      #
      # "spotBNBBurn" and "interestBNBBurn" should be sent at least one.
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :spotBNBBurn "true" or "false"; Determines whether to use BNB to pay for trading fees on SPOT
      # @option kwargs [String] :interestBNBBurn "true" or "false"; Determines whether to use BNB to pay for margin loan's interest
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#toggle-bnb-burn-on-spot-trade-and-margin-interest-user_data
      def toggle_bnb_burn(**kwargs)
        @session.sign_request(:post, '/sapi/v1/bnbBurn', params: kwargs)
      end

      # Get BNB Burn Status (USER_DATA)
      #
      # GET /sapi/v1/bnbBurn
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-bnb-burn-status-user_data
      def get_bnb_burn(**kwargs)
        @session.sign_request(:get, '/sapi/v1/bnbBurn', params: kwargs)
      end

      # Query Margin Interest Rate History (USER_DATA)
      #
      # GET /sapi/v1/margin/interestRateHistory
      #
      # @param asset [String]
      # @param kwargs [Hash]
      # @option vipLevel [Integer] Default: user's vip level
      # @option startTime [Integer] Default: 7 days ago
      # @option endTime [Integer] Default: present. Maximum range: 3 months.
      # @option limit [Integer] Default: 20. Maximum: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-margin-interest-rate-history-user_data
      def get_margin_interest_rate_history(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/margin/interestRateHistory', params: kwargs.merge(asset: asset))
      end
    end
  end
end
