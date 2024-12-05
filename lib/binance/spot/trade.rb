# frozen_string_literal: true

module Binance
  class Spot
    # This module includes all spot trading methods, including:
    # - place orders (spot and oco)
    # - query orders (spot and oco)
    # - cancel orders (spot and oco)
    # - account information
    # - my trades
    # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api
    module Trade
      # TestNew Order
      #
      # POST /api/v3/order/test
      #
      # send in a new order to test the request, no order is really generated.
      #
      # @param symbol [String] the symbol
      # @param side [String]
      # @param type [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :timeInForce
      # @option kwargs [Float] :quantity
      # @option kwargs [Float] :quoteOrderQty
      # @option kwargs [Float] :price
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Float] :stopPrice
      # @option kwargs [Float] :icebergeQty
      # @option kwargs [String] :newOrderRespType Set the response JSON. ACK, RESULT, or FULL.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#test-new-order-trade
      def new_order_test(symbol:, side:, type:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/api/v3/order/test', params: kwargs.merge(
          symbol: symbol,
          side: side,
          type: type
        ))
      end

      # New Order
      #
      # POST /api/v3/order
      #
      # send in a new order
      #
      # @param symbol [String] the symbol
      # @param side [String]
      # @param type [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :timeInForce
      # @option kwargs [Float] :quantity
      # @option kwargs [Float] :quoteOrderQty
      # @option kwargs [Float] :price
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Float] :stopPrice
      # @option kwargs [Float] :icebergeQty
      # @option kwargs [String] :newOrderRespType Set the response JSON. ACK, RESULT, or FULL.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#new-order-trade
      def new_order(symbol:, side:, type:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/api/v3/order', params: kwargs.merge(
          symbol: symbol,
          side: side,
          type: type
        ))
      end

      # Cancel Order (TRADE)
      #
      # DELETE /api/v3/order
      #
      # @param symbol [String] the symbol
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderId
      # @option kwargs [String] :origClientOrderId
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#cancel-order-trade
      def cancel_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/api/v3/order', params: kwargs.merge(symbol: symbol))
      end

      # Cancel all Open Orders on a Symbol (TRADE)
      #
      # DELETE /api/v3/openOrders
      #
      # @param symbol [String] the symbol
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#cancel-all-open-orders-on-a-symbol-trade
      def cancel_open_orders(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/api/v3/openOrders', params: kwargs.merge(symbol: symbol))
      end

      # Query Order (USER_DATA)
      #
      # GET /api/v3/order
      #
      # @param symbol [String] the symbol
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderId
      # @option kwargs [String] :origClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-order-user_data
      def get_order(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/api/v3/order', params: kwargs.merge(symbol: symbol))
      end

      # Current Open Orders (USER_DATA)
      #
      # GET /api/v3/openOrders
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol the symbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#current-open-orders-user_data
      def open_orders(**kwargs)
        @session.sign_request(:get, '/api/v3/openOrders', params: kwargs)
      end

      # All Orders (USER_DATA)
      #
      # GET /api/v3/allOrders
      #
      # Get all account orders; active, canceled, or filled.
      #
      # @param symbol [String] the symbol
      # @param kwargs [Hash]
      # @option kwargs [String] :orderId
      # @option kwargs [String] :startTime
      # @option kwargs [String] :endTime
      # @option kwargs [String] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#all-orders-user_data
      def all_orders(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/api/v3/allOrders', params: kwargs.merge(symbol: symbol))
      end

      # New OCO (TRADE)
      #
      # POST /api/v3/order/oco
      #
      # Send in a new OCO
      #
      # @param symbol [String] the symbol
      # @param side [String]
      # @param quantity [Float]
      # @param aboveType [String]
      # @param belowType [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :listClientOrderId
      # @option kwargs [String] :aboveClientOrderId Arbitrary unique ID among open orders for the above order. Automatically generated if not sent
      # @option kwargs [Integer] :aboveIcebergQty Note that this can only be used if aboveTimeInForce is GTC
      # @option kwargs [Float] :abovePrice
      # @option kwargs [Float] :aboveStopPriceCan be used if aboveType is STOP_LOSS or STOP_LOSS_LIMIT. Either aboveStopPrice or aboveTrailingDelta or both, must be specified.
      # @option kwargs [Integer] :aboveTrailingDelta
      # @option kwargs [Float] :aboveTimeInForce Required if the aboveType is STOP_LOSS_LIMIT.
      # @option kwargs [Integer] :aboveStrategyId Arbitrary numeric value identifying the above order within an order strategy.
      # @option kwargs [Integer] :aboveStrategyType Arbitrary numeric value identifying the above order strategy. Values smaller than 1000000 are reserved and cannot be used.
      # @option kwargs [String] :belowClientOrderId Arbitrary unique ID among open orders for the below order. Automatically generated if not sent
      # @option kwargs [Integer] :belowIcebergQty Note that this can only be used if belowTimeInForce is GTC
      # @option kwargs [Float] :belowPrice Can be used if belowType is STOP_LOSS_LIMIT or LIMIT_MAKER to specify the limit price.
      # @option kwargs [Float] :belowStopPrice Can be used if belowType is STOP_LOSS or STOP_LOSS_LIMIT. Either belowStopPrice or belowTrailingDelta or both, must be specified.
      # @option kwargs [Integer] :belowTrailingDelta
      # @option kwargs [String] :belowTimeInForce Required if the belowType is STOP_LOSS_LIMIT
      # @option kwargs [Integer] :belowStrategyId Arbitrary numeric value identifying the below order within an order strategy
      # @option kwargs [String] :belowStrategyType Arbitrary numeric value identifying the below order strategy. Values smaller than 1000000 are reserved and cannot be used.
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#new-order-list---oco-trade
      def new_oco_order(symbol:, side:, quantity:, aboveType:, belowType:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('quantity', quantity)
        Binance::Utils::Validation.require_param('aboveType', aboveType)
        Binance::Utils::Validation.require_param('belowType', belowType)

        @session.sign_request(:post, '/api/v3/order/oco', params: kwargs.merge(
          symbol: symbol,
          side: side,
          quantity: quantity,
          aboveType: aboveType,
          belowType: belowType
        ))
      end

      # Cancel OCO (TRADE)
      #
      # DELETE /api/v3/orderList
      #
      # @param symbol [String] the symbol
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderListId
      # @option kwargs [String] :listClientOrderId
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#cancel-order-list-trade
      def cancel_order_list(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:delete, '/api/v3/orderList', params: kwargs.merge(symbol: symbol))
      end

      # Query OCO (USER_DATA)
      #
      # GET /api/v3/orderList
      #
      # Retrieves a specific OCO based on provided optional parameters
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderListId
      # @option kwargs [String] :orgClientOrderId
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-order-list-user_data
      def order_list(**kwargs)
        @session.sign_request(:get, '/api/v3/orderList', params: kwargs)
      end

      # Query all OCO (USER_DATA)
      #
      # GET /api/v3/allOrderList
      #
      # Retrieves all OCO based on provided optional parameters
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :fromId
      # @option kwargs [String] :startTime
      # @option kwargs [String] :endTime
      # @option kwargs [String] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-all-order-lists-user_data
      def all_order_list(**kwargs)
        @session.sign_request(:get, '/api/v3/allOrderList', params: kwargs)
      end

      # Query Open OCO (USER_DATA)
      #
      # GET /api/v3/openOrderList
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-open-order-lists-user_data
      def open_order_list(**kwargs)
        @session.sign_request(:get, '/api/v3/openOrderList', params: kwargs)
      end

      # Account Information (USER_DATA)
      #
      # GET /api/v3/account
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#account-information-user_data
      def account(**kwargs)
        @session.sign_request(:get, '/api/v3/account', params: kwargs)
      end

      # Account Trade List (USER_DATA)
      #
      # GET /api/v3/myTrades
      #
      # @param symbol [String] the symbol
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderId
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :fromId TradeId to fetch from. Default gets most recent trades.
      # @option kwargs [Integer] :limit Default 500; max 1000.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#account-trade-list-user_data
      def my_trades(symbol:, **kwargs)
        @session.sign_request(:get, '/api/v3/myTrades', params: kwargs.merge(symbol: symbol))
      end

      # Query Current Order Count Usage (TRADE)
      #
      # GET /api/v3/rateLimit/order
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-unfilled-order-count-user_data
      def get_order_rate_limit(**kwargs)
        @session.sign_request(:get, '/api/v3/rateLimit/order', params: kwargs)
      end

      # Query Prevented Matches (USER_DATA)
      #
      # GET /api/v3/myPreventedMatches
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @param kwargs [Integer] :preventedMatchId
      # @param kwargs [Integer] :orderId
      # @param kwargs [Integer] :fromPreventedMatchId
      # @param kwargs [Integer] :limit Default: 500; Max: 1000
      # @param kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-prevented-matches-user_data
      def my_prevented_matches(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/api/v3/myPreventedMatches', params: kwargs.merge(symbol: symbol))
      end

      # Query Allocations (USER_DATA)
      #
      # GET /api/v3/myAllocations
      #
      # @param symbol [String]
      # @param kwargs [Hash]
      # @param kwargs [Integer] :startTime
      # @param kwargs [Integer] :endTime
      # @param kwargs [Integer] :fromAllocationId
      # @param kwargs [Integer] :limit Default 500;Max 1000
      # @param kwargs [Integer] :orderId
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-allocations-user_data
      def my_allocations(symbol:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/api/v3/myAllocations', params: kwargs.merge(symbol: symbol))
      end

      # Query Commission Rates (USER_DATA)
      #
      # GET /api/v3/account/commission
      #
      # @param symbol [String]
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#query-commission-rates-user_data
      def commission_rate(symbol:)
        Binance::Utils::Validation.require_param('symbol', symbol)

        @session.sign_request(:get, '/api/v3/account/commission', params: { symbol: symbol })
      end

      # Cancel an Existing Order and Send a New Order (TRADE)
      #
      # POST /api/v3/order/cancelReplace
      #
      # @param symbol [String] the symbol
      # @param side [String]
      # @param type [String]
      # @param cancelReplaceMode [String] STOP_ON_FAILURE or ALLOW_FAILURE
      # @param kwargs [Hash]
      # @option kwargs [String] :timeInForce
      # @option kwargs [Float] :quantity
      # @option kwargs [Float] :quoteOrderQty
      # @option kwargs [Float] :price
      # @option kwargs [String] :cancelNewClientOrderId
      # @option kwargs [String] :cancelOrigClientOrderId
      # @option kwargs [Integer] :cancelOrderId
      # @option kwargs [String] :newClientOrderId
      # @option kwargs [Integer] :strategyId
      # @option kwargs [Integer] :strategyType The value cannot be less than 1000000
      # @option kwargs [Float] :stopPrice
      # @option kwargs [Integer] :trailingDelta
      # @option kwargs [Float] :icebergQty
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [String] :selfTradePreventionMode The allowed enums is dependent on what is configured on the symbo
      # @option kwargs [String] :cancelRestrictions ONLY_NEW - Cancel will succeed if the order status is NEW. ONLY_PARTIALLY_FILLED - Cancel will succeed if order status is PARTIALLY_FILLED
      # @option kwargs [String] :orderRateLimitExceededMode DO_NOTHING (default)- will only attempt to cancel the order if account has not exceeded the unfilled order rate limit
      #                          CANCEL_ONLY - will always cancel the order
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/binance-spot-api-docs/rest-api/public-api-endpoints#cancel-an-existing-order-and-send-a-new-order-trade
      def cancel_replace(symbol:, side:, type:, cancelReplaceMode:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('type', type)
        Binance::Utils::Validation.require_param('cancelReplaceMode', cancelReplaceMode)

        @session.sign_request(:post, '/api/v3/order/cancelReplace',
                              params: kwargs.merge(
                                symbol: symbol,
                                side: side,
                                type: type,
                                cancelReplaceMode: cancelReplaceMode
                              ))
      end
    end
  end
end
