# frozen_string_literal: true

module Binance
  class Spot
    # Fiat endpoints
    # @see https://developers.binance.com/docs/fiat/Introduction
    module Fiat
      # Get Fiat Deposit/Withdraw History (USER_DATA)
      #
      # GET /sapi/v1/fiat/orders
      #
      # @param transactionType [String] 0-deposit,1-withdraw
      # @param kwargs [Hash]
      # @option kwargs [Integer] :beginTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :endTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :page default 1
      # @option kwargs [Integer] :rows default 100, max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/fiat/rest-api/Get-Fiat-Deposit-Withdraw-History
      def fiat_deposit_withdraw_history(transactionType:, **kwargs)
        Binance::Utils::Validation.require_param('transactionType', transactionType)

        @session.sign_request(:get, '/sapi/v1/fiat/orders', params: kwargs.merge(
          transactionType: transactionType
        ))
      end

      # Get Fiat Payments History (USER_DATA)
      #
      # GET /sapi/v1/fiat/payments
      #
      # @param transactionType [String] 0-buy,1-sell
      # @param kwargs [Hash]
      # @option kwargs [Integer] :beginTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :endTime If beginTime and endTime are not sent, the recent 30-day data will be returned.
      # @option kwargs [Integer] :page default 1
      # @option kwargs [Integer] :rows default 100, max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/fiat/rest-api/Get-Fiat-Payments-History
      def fiat_payment_history(transactionType:, **kwargs)
        Binance::Utils::Validation.require_param('transactionType', transactionType)

        @session.sign_request(:get, '/sapi/v1/fiat/payments', params: kwargs.merge(
          transactionType: transactionType
        ))
      end
    end
  end
end
