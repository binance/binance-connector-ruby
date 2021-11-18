# frozen_string_literal: true

module Binance
  class Spot
    # all loan endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#crypto-loans-endpoints
    module Loan
      # Get Crypto Loans Income History (USER_DATA)
      #
      # GET /sapi/v1/loan/income
      #
      # @param asset [String]
      # @option kwargs [String] :type
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 20, max 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-crypto-loans-income-history-user_data
      def get_loan_history(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:get, '/sapi/v1/loan/income', params: kwargs.merge(asset: asset))
      end
    end
  end
end
