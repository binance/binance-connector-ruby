# frozen_string_literal: true

module Binance
  class Spot
    # User data stream endpoints
    # @see https://developers.binance.com/docs/binance-spot-api-docs/user-data-stream
    module Stream
      # Create a ListenKey (USER_STREAM)
      #
      # POST /api/v3/userDataStream
      def new_listen_key
        @session.limit_request(method: :post, path: '/api/v3/userDataStream')
      end

      # Ping/Keep-alive a ListenKey (USER_STREAM)
      #
      # PUT /api/v3/userDataStream
      #
      # @param listenKey [String]
      def renew_listen_key(listenKey)
        @session.limit_request(method: :put, path: '/api/v3/userDataStream', params: { listenKey: listenKey })
      end

      # Close a ListenKey (USER_STREAM)
      #
      # DELETE /api/v3/userDataStream
      #
      # @param listenKey [String]
      def delete_listen_key(listenKey)
        @session.limit_request(method: :delete, path: '/api/v3/userDataStream', params: { listenKey: listenKey })
      end

      # Margin

      # Create a ListenKey (USER_STREAM)
      #
      # POST /sapi/v1/userDataStream
      def new_margin_listen_key
        @session.limit_request(method: :post, path: '/sapi/v1/userDataStream')
      end

      # Ping/Keep-alive a ListenKey (USER_STREAM)
      #
      # PUT /sapi/v1/userDataStream
      #
      # @param listenKey [String]
      def renew_margin_listen_key(listenKey)
        @session.limit_request(method: :put, path: '/sapi/v1/userDataStream', params: { listenKey: listenKey })
      end

      # Close a ListenKey (USER_STREAM)
      #
      # DELETE /sapi/v1/userDataStream
      #
      # @param listenKey [String]
      def delete_margin_listen_key(listenKey)
        @session.limit_request(method: :delete, path: '/sapi/v1/userDataStream', params: { listenKey: listenKey })
      end
    end
  end
end
