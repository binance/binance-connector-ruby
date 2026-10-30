# frozen_string_literal: true

module Binance
  class Spot
    # Dual Investment endpoints
    # @see https://developers.binance.com/en/docs/catalog/investment-and-services-dual-investment
    module DCI
      # Get Dual Investment product list (USER_DATA)
      #
      # GET /sapi/v1/dci/product/list
      #
      # @param optionType [String] CALL or PUT
      # @param exercisedCoin [String] Target exercised asset
      # @param investCoin [String] Asset used for subscribing
      # @param kwargs [Hash]
      # @option kwargs [Integer] :pageSize Number of records per page
      # @option kwargs [Integer] :pageIndex Page index
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/en/docs/catalog/investment-and-services-dual-investment/api/rest-api/market-data#get-dual-investment-product-list
      def dual_investment_products(optionType:, exercisedCoin:, investCoin:, **kwargs)
        Binance::Utils::Validation.require_param('optionType', optionType)
        Binance::Utils::Validation.require_param('exercisedCoin', exercisedCoin)
        Binance::Utils::Validation.require_param('investCoin', investCoin)

        @session.sign_request(:get, '/sapi/v1/dci/product/list', params: kwargs.merge(
          optionType: optionType,
          exercisedCoin: exercisedCoin,
          investCoin: investCoin
        ))
      end

      # Get Dual Investment positions (USER_DATA)
      #
      # GET /sapi/v1/dci/product/positions
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :status PENDING, PURCHASE_SUCCESS, SETTLED, PURCHASE_FAIL, REFUNDING, REFUND_SUCCESS or SETTLING. All statuses if omitted
      # @option kwargs [Integer] :pageSize Number of records per page
      # @option kwargs [Integer] :pageIndex Page index
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/en/docs/catalog/investment-and-services-dual-investment/api/rest-api/trade#get-dual-investment-positions
      def dual_investment_positions(**kwargs)
        @session.sign_request(:get, '/sapi/v1/dci/product/positions', params: kwargs)
      end
    end
  end
end
