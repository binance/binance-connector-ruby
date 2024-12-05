# frozen_string_literal: true

module Binance
  class Spot
    # Convert endpoints
    # @see https://developers.binance.com/docs/convert/Introduction
    module Convert
      # List All Convert Pairs
      #
      # GET /sapi/v1/convert/exchangeInfo
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :fromAsset Either fromAsset or toAsset or both should be send. User spends coin
      # @option kwargs [String] :toAsset Either fromAsset or toAsset or both should be send. User spends coin
      # @see https://developers.binance.com/docs/convert/market-data
      def convert_exchange_info(**kwargs)
        @session.sign_request(:get, '/sapi/v1/convert/exchangeInfo', params: kwargs)
      end

      # Query order quantity precision per asset (USER_DATA)
      #
      # GET /sapi/v1/convert/assetInfo
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/market-data/Query-order-quantity-precision-per-asset
      def convert_asset_info(**kwargs)
        @session.sign_request(:get, '/sapi/v1/convert/assetInfo', params: kwargs)
      end

      # Send Quote Request (USER_DATA)
      #
      # POST /sapi/v1/convert/getQuote
      #
      # @param fromAsset [String]
      # @param toAsset [String]
      # @param kwargs [Hash]
      # @option kwargs [Float] :fromAmount Either fromAmount or toAmount should be specified. When specified, it is the amount you will be debited after the conversion
      # @option kwargs [Float] :toAmount Either fromAmount or toAmount should be specified. When specified, it is the amount you will be credited after the conversion
      # @option kwargs [String] :walletType SPOT or FUNDING. Default is SPOT
      # @option kwargs [String] :validTime 10s, 30s, 1m, default 10s
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/trade
      def convert_get_quote(fromAsset:, toAsset:, **kwargs)
        Binance::Utils::Validation.require_param('fromAsset', fromAsset)
        Binance::Utils::Validation.require_param('toAsset', toAsset)

        @session.sign_request(:post, '/sapi/v1/convert/getQuote', params: kwargs.merge(
          fromAsset: fromAsset,
          toAsset: toAsset
        ))
      end

      # Accept Quote (TRADE)
      #
      # POST /sapi/v1/convert/acceptQuote
      #
      # @param quoteId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/trade/Accept-Quote
      def convert_accept_quote(quoteId:, **kwargs)
        Binance::Utils::Validation.require_param('quoteId', quoteId)

        @session.sign_request(:post, '/sapi/v1/convert/acceptQuote', params: kwargs.merge(
          quoteId: quoteId
        ))
      end

      # Get Convert Trade History (USER_DATA)
      #
      # GET /sapi/v1/convert/tradeFlow
      #
      # @param startTime [Integer]
      # @param endTime [Integer]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :limit default 100, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/trade/Get-Convert-Trade-History
      def convert_trade_flow(startTime:, endTime:, **kwargs)
        Binance::Utils::Validation.require_param('startTime', startTime)
        Binance::Utils::Validation.require_param('endTime', endTime)

        @session.sign_request(:get, '/sapi/v1/convert/tradeFlow', params: kwargs.merge(
          startTime: startTime,
          endTime: endTime
        ))
      end

      # Order status (USER_DATA)
      #
      # GET /sapi/v1/convert/orderStatus
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :orderId Either orderId or quoteId is required
      # @option kwargs [String] :quoteId Either orderId or quoteId is required
      # @see https://developers.binance.com/docs/convert/trade/Order-Status
      def convert_order_status(**kwargs)
        @session.sign_request(:get, '/sapi/v1/convert/orderStatus', params: kwargs)
      end

      # Place limit order (USER_DATA)
      #
      # POST /sapi/v1/convert/limit/placeOrder
      #
      # @param baseAsset [String] base asset (use the response fromIsBase from GET /sapi/v1/convert/exchangeInfo api to check which one is baseAsset)
      # @param quoteAsset [String] quote asset
      # @param limitPrice [Float] Symbol limit price (from baseAsset to quoteAsset)
      # @param side [String] BUY or SELL
      # @param expiredType [String] 1_D, 3_D, 7_D, 30_D (D means day)
      # @param kwargs [Hash]
      # @option kwargs [Float] :baseAmount Base asset amount. (One of baseAmount or quoteAmount is required)
      # @option kwargs [Float] :quoteAmount Quote asset amount. (One of baseAmount or quoteAmount is required)
      # @option kwargs [String] :walletType SPOT or FUNDING or SPOT_FUNDING. It is to use which type of assets. Default is SPOT.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/trade/Place-Order
      def convert_limit_place_order(baseAsset:, quoteAsset:, limitPrice:, side:, expiredType:, **kwargs)
        Binance::Utils::Validation.require_param('baseAsset', baseAsset)
        Binance::Utils::Validation.require_param('quoteAsset', quoteAsset)
        Binance::Utils::Validation.require_param('limitPrice', limitPrice)
        Binance::Utils::Validation.require_param('side', side)
        Binance::Utils::Validation.require_param('expiredType', expiredType)

        @session.sign_request(:post, '/sapi/v1/convert/limit/placeOrder', params: kwargs.merge(
          baseAsset: baseAsset,
          quoteAsset: quoteAsset,
          limitPrice: limitPrice,
          side: side,
          expiredType: expiredType
        ))
      end

      # Cancel limit order (USER_DATA)
      #
      # POST /sapi/v1/convert/limit/cancelOrder
      #
      # @param orderId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/trade/Cancel-Order
      def convert_limit_cancel_order(orderId:, **kwargs)
        Binance::Utils::Validation.require_param('orderId', orderId)

        @session.sign_request(:post, '/sapi/v1/convert/limit/cancelOrder', params: kwargs.merge(
          orderId: orderId
        ))
      end

      # Query limit open orders (USER_DATA)
      #
      # POST /sapi/v1/convert/limit/queryOpenOrders
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/convert/trade/Query-Order
      def convert_limit_query_open_orders(**kwargs)
        @session.sign_request(:post, '/sapi/v1/convert/limit/queryOpenOrders', params: kwargs)
      end
    end
  end
end
