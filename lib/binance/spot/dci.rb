# frozen_string_literal: true

module Binance
  class Spot
    #  Dual Investment endpoints
    # @see https://developers.binance.com/docs/dual_investment/change-log
    module DCI
      # Get Dual Investment product list
      #
      # GET /sapi/v1/dci/product/list
      #
      # @param optionType [String]
      # @param exercisedCoin [String]
      # @param investCoin [String]
      # @option kwargs [Integer] :pageSize
      # @option kwargs [Integer] :pageIndex
      # @option kwargs [Integer] :recvWindow
      # @option kwargs [Integer] :timestamp
      # @see https://developers.binance.com/docs/dual_investment/market-data
      def dual_investment_products(optionType:, exercisedCoin:, investCoin:, **kwargs)
        Binance::Utils::Validation.require_param('optionType', optionType)
        Binance::Utils::Validation.require_param('exercisedCoin', exercisedCoin)
        Binance::Utils::Validation.require_param('investCoin', investCoin)

        params = kwargs.merge(optionType: optionType, exercisedCoin: exercisedCoin, investCoin: investCoin)
        @session.sign_request(:get, '/sapi/v1/dci/product/list', params: params)
      end

      # Get Dual Investment positions (batch)
      #
      # GET /sapi/v1/dci/product/positions
      #
      # @option kwargs [String] :status
      # @option kwargs [Integer] :pageSize
      # @option kwargs [Integer] :pageIndex
      # @option kwargs [Integer] :recvWindow
      # @option kwargs [Integer] :timestamp
      # @see https://developers.binance.com/docs/dual_investment/trade/Get-Dual-Investment-positions
      def dual_investment_positions(**kwargs)
        @session.sign_request(:get, '/sapi/v1/dci/product/positions', params: kwargs)
      end
    end
  end
end
