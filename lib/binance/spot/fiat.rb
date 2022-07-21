# frozen_string_literal: true

module Binance
  class Spot
    # Fiat endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#fiat-endpoints
    module Fiat
      # Get Fiat Deposit/Withdraw History (USER_DATA)
      #
      # GET /sapi/v1/fiat/orders
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param transactionType [String] 0-deposit,1-withdraw
      # @param kwargs [Hash]
      # @option kwargs [Integer] :beginTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :endTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :page default 1
      # @option kwargs [Integer] :rows default 100, max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-fiat-deposit-withdraw-history-user_data
      def fiat_deposit_withdraw_history(timestamp = present_timestamp, transactionType:, **kwargs)
        Binance::Utils::Validation.require_param('transactionType', transactionType)

        @session.sign_request(:get, '/sapi/v1/fiat/orders', timestamp, params: kwargs.merge(
          transactionType: transactionType
        ))
      end

      # Get Fiat Payments History (USER_DATA)
      #
      # GET /sapi/v1/fiat/payments
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param transactionType [String] 0-buy,1-sell
      # @param kwargs [Hash]
      # @option kwargs [Integer] :beginTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :endTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :page default 1
      # @option kwargs [Integer] :rows default 100, max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-fiat-payments-history-user_data
      def fiat_payment_history(timestamp = present_timestamp, transactionType:, **kwargs)
        Binance::Utils::Validation.require_param('transactionType', transactionType)

        @session.sign_request(:get, '/sapi/v1/fiat/payments', timestamp, params: kwargs.merge(
          transactionType: transactionType
        ))
      end
    end
  end
end
