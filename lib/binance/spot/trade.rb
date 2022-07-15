# frozen_string_literal: true

module Binance
  class Spot
    # This module includes all spot trading methods, including:
    # - place orders (spot and oco)
    # - query orders (spot and oco)
    # - cancel orders (spot and oco)
    # - account information
    # - my trades
    # @see https://binance-docs.github.io/apidocs/spot/en/#spot-account-trade
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#test-new-order-trade
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#new-order-trade
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#cancel-order-trade
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#cancel-all-open-orders-on-a-symbol-trade
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-order-user_data
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#current-open-orders-user_data
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#all-orders-user_data
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
      # @param price [Float]
      # @param stopPrice [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :listClientOrderId
      # @option kwargs [String] :limitClientOrderId
      # @option kwargs [Float] :limitIcebergQty
      # @option kwargs [String] :stopClientOrderId
      # @option kwargs [Float] :stopLimitPrice
      # @option kwargs [Float] :stopIcebergQty
      # @option kwargs [Float] :stopLimitTimeInForce GTC/ FOK/ IOC
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#new-oco-trade
      def new_oco_order(symbol:, side:, quantity:, price:, stopPrice:, **kwargs)
        Binance::Utils::Validation.require_param('symbol', symbol)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('quantity', quantity)
        Binance::Utils::Validation.require_param('price', price)
        Binance::Utils::Validation.require_param('stopPrice', stopPrice)

        @session.sign_request(:post, '/api/v3/order/oco', params: kwargs.merge(
          symbol: symbol,
          side: side,
          quantity: quantity,
          price: price,
          stopPrice: stopPrice
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#cancel-oco-trade
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-oco-user_data
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-all-oco-user_data
      def all_order_list(**kwargs)
        @session.sign_request(:get, '/api/v3/allOrderList', params: kwargs)
      end

      # Query Open OCO (USER_DATA)
      #
      # GET /api/v3/openOrderList
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-open-oco-user_data
      def open_order_list(**kwargs)
        @session.sign_request(:get, '/api/v3/openOrderList', params: kwargs)
      end

      # Account Information (USER_DATA)
      #
      # GET /api/v3/account
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-information-user_data
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
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-trade-list-user_data
      def my_trades(symbol:, **kwargs)
        @session.sign_request(:get, '/api/v3/myTrades', params: kwargs.merge(symbol: symbol))
      end

      # Query Current Order Count Usage (TRADE)
      #
      # GET /api/v3/rateLimit/order
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-current-order-count-usage-trade
      def get_order_rate_limit(**kwargs)
        @session.sign_request(:get, '/api/v3/rateLimit/order', params: kwargs)
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
      # @option kwargs [Float] :stopPrice
      # @option kwargs [Integer] :trailingDelta
      # @option kwargs [Float] :icebergQty
      # @option kwargs [String] :newOrderRespType
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cancel-an-existing-order-and-send-a-new-order-trade
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
