# frozen_string_literal: true

require 'binance/websocket_base'

module Binance
  class Spot
    # Spot Websocket
    class WebSocket < WebSocketBase
      BASE_URL = 'wss://stream.binance.com:9443'

      def initialize(options = {})
        @base_url = options[:base_url] || BASE_URL
        options[:base_url] = @base_url
        super(options)
      end

      # Aggregate Trade Streams
      # The Aggregate Trade Streams push trade information that is aggregated for a single taker order.
      # Stream Name: <symbol>@aggTrade
      # Update Speed: Real-time
      #
      # @param symbol [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#aggregate-trade-streams
      def agg_trade(symbol:, callbacks:)
        url = "#{@base_url}/ws/#{symbol.downcase}@aggTrade"
        create_connection(url, callbacks)
      end

      # Trade Streams
      # The Trade Streams push raw trade information; each trade has a unique buyer and seller.
      # Stream Name: <symbol>@trade
      # Update Speed: Real-time
      #
      # @param symbol [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#trade-streams
      def trade(symbol:, callbacks:)
        url = "#{@base_url}/ws/#{symbol.downcase}@trade"
        create_connection(url, callbacks)
      end

      # Kline/Candlestick Streams
      # The Kline/Candlestick Stream push updates to the current klines/candlestick every second.
      # Stream Name: <symbol>@kline_<interval>
      # Update Speed: 2000ms
      #
      # @param symbol [String]
      # @param interval [String] 1m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 8h, 12h, 1d, 3d, 1w, 1M
      # @see https://binance-docs.github.io/apidocs/spot/en/#kline-candlestick-streams
      def kline(symbol:, interval:, callbacks:)
        url = "#{@base_url}/ws/#{symbol.downcase}@kline_#{interval}"
        create_connection(url, callbacks)
      end

      # Individual Symbol Mini Ticker Stream or All Market Mini Tickers Stream
      # 24hr rolling window mini-ticker statistics. These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
      # Stream Name: <symbol>@miniTicker or !miniTicker@arr
      # Update Speed: 1000ms
      #
      # @option symbol [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#individual-symbol-mini-ticker-stream
      def mini_ticker(callbacks:, symbol: nil)
        url = if symbol.nil?
                "#{@base_url}/ws/!miniTicker@arr"
              else
                "#{@base_url}/ws/#{symbol.downcase}@miniTicker"
              end
        create_connection(url, callbacks)
      end

      # Individual Symbol Ticker Streams or All Market Tickers Stream
      # 24hr rollwing window ticker statistics for a single symbol. These are NOT the statistics of the UTC day, but a 24hr rolling window for the previous 24hrs.
      # Stream Name: <symbol>@ticker or !ticker@arr
      # Update Speed: 1000ms
      #
      # @option symbol [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#individual-symbol-ticker-streams
      def symbol_ticker(callbacks:, symbol: nil)
        url = if symbol.nil?
                "#{@base_url}/ws/!ticker@arr"
              else
                "#{@base_url}/ws/#{symbol.downcase}@ticker"
              end
        create_connection(url, callbacks)
      end

      # Individual Symbol Book Ticker Streams or All Book Tickers Stream
      # Pushes any update to the best bid or ask's price or quantity in real-time for a specified symbol.
      # Stream Name: <symbol>@bookTicker or !bookTicker
      # Update Speed: Real-time
      #
      # @option symbol [String]
      # @see https://binance-docs.github.io/apidocs/spot/en/#individual-symbol-book-ticker-streams
      def book_ticker(callbacks:, symbol: nil)
        url = if symbol.nil?
                "#{@base_url}/ws/!bookTicker"
              else
                "#{@base_url}/ws/#{symbol.downcase}@bookTicker"
              end
        create_connection(url, callbacks)
      end

      # Partial Book Depth Streams
      # Top bids and asks, Valid are 5, 10, or 20.
      # Stream Name: <symbol>@depth<levels> OR <symbol>@depth<levels>@100ms.
      # Update Speed: 1000ms or 100ms
      #
      # @param symbol [String]
      # @param levels [Integer] 5, 10, or 20.
      # @param speed [String] 1000ms or 100ms
      # @see https://binance-docs.github.io/apidocs/spot/en/#partial-book-depth-streams
      def partial_book_depth(symbol:, levels:, speed:, callbacks:)
        url = "#{@base_url}/ws/#{symbol.downcase}@depth#{levels}@#{speed}"
        create_connection(url, callbacks)
      end

      # Diff. Depth Stream
      # Top bids and asks, Valid are 5, 10, or 20.
      # Stream Name: <symbol>@depth<levels> OR <symbol>@depth<levels>@100ms.
      # Update Speed: 1000ms or 100ms
      #
      # @param symbol [String]
      # @param speed [String] 1000ms or 100ms
      # @see https://binance-docs.github.io/apidocs/spot/en/#diff-depth-stream
      def diff_book_depth(symbol:, speed:, callbacks:)
        url = "#{@base_url}/ws/#{symbol.downcase}@depth@#{speed}"
        create_connection(url, callbacks)
      end

      # Subscribe to a stream manually
      # subscribe(stream: "btcusdt@miniTicker") or
      # subscribe(stream: ["btcusdt@miniTicker", "ethusdt@miniTicker"])
      #
      # @param stream [String|Array]
      def subscribe(stream:, callbacks:)
        url = if stream.is_a?(Array)
                "#{@base_url}/stream?streams=#{stream.join('/')}"
              else
                "#{@base_url}/ws/#{stream}"
              end

        subscribe_to(url, callbacks)
      end

      alias user_data subscribe
    end
  end
end
