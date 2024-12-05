# frozen_string_literal: true

module Binance
  class Spot
    # all loan endpoints
    # @see https://developers.binance.com/docs/crypto_loan/Introduction
    module Loan
      # Get Flexible Loan Collateral Assets Data (USER_DATA)
      #
      # GET /sapi/v2/loan/flexible/collateral/data
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/market-data
      def get_flexible_loan_collateral_data(**kwargs)
        @session.sign_request(:get, '/sapi/v2/loan/flexible/collateral/data', params: kwargs)
      end

      # Get Flexible Loan Assets Data (USER_DATA)
      #
      # GET /sapi/v2/loan/flexible/loanable/data
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/market-data/Get-Flexible-Loan-Assets-Data
      def get_flexible_loan_assets_data(**kwargs)
        @session.sign_request(:get, '/sapi/v2/loan/flexible/loanable/data', params: kwargs)
      end

      # Flexible Loan Borrow (TRADE)
      #
      # POST /sapi/v2/loan/flexible/borrow
      #
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Float] :loanAmount Mandatory when collateralAmount is empty
      # @option kwargs [Float] :collateralAmount Mandatory when loanAmount is empty
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/trade
      def borrow_flexible_loan(loanCoin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param('loanCoin', loanCoin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)

        @session.sign_request(:post, '/sapi/v2/loan/flexible/borrow', params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin
        ))
      end

      # Flexible Loan Repay (TRADE)
      #
      # POST /sapi/v2/loan/flexible/repay
      #
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param repayAmount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Boolean] :collateralReturn Default: TRUE. TRUE: Return extra collateral to spot account; FALSE: Keep extra collateral in the order, and lower LTV.
      # @option kwargs [Boolean] :fullRepayment Default: FALSE. TRUE: Full repayment; FALSE: Partial repayment, based on loanAmount
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/trade/Flexible-Loan-Repay
      def repay_flexible_loan(loanCoin:, collateralCoin:, repayAmount:, **kwargs)
        Binance::Utils::Validation.require_param('loanCoin', loanCoin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)
        Binance::Utils::Validation.require_param('repayAmount', repayAmount)

        @session.sign_request(:post, '/sapi/v2/loan/flexible/repay', params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin,
          repayAmount: repayAmount
        ))
      end

      # Flexible Loan Adjust LTV (TRADE)
      #
      # POST /sapi/v2/loan/flexible/adjust/ltv
      #
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param adjustmentAmount [Float]
      # @param direction [String] ADDITIONAL or REDUCED
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/trade/Flexible-Loan-Adjust-LTV
      def adjust_flexible_loan_ltv(loanCoin:, collateralCoin:, adjustmentAmount:, direction:, **kwargs)
        Binance::Utils::Validation.require_param('loanCoin', loanCoin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)
        Binance::Utils::Validation.require_param('adjustmentAmount', adjustmentAmount)
        Binance::Utils::Validation.require_param('direction', direction)

        @session.sign_request(:post, '/sapi/v2/loan/flexible/adjust/ltv', params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin,
          adjustmentAmount: adjustmentAmount,
          direction: direction
        ))
      end

      # Get Flexible Loan LTV Adjustment History (USER_DATA)
      #
      # GET /sapi/v2/loan/flexible/ltv/adjustment/history
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/user-information
      def get_flexible_loan_ltv_adjustment_history(**kwargs)
        @session.sign_request(:get, '/sapi/v2/loan/flexible/ltv/adjustment/history', params: kwargs)
      end

      # Get Flexible Loan Borrow History(USER_DATA)
      #
      # GET /sapi/v2/loan/flexible/borrow/history
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/user-information/Get-Flexible-Loan-Borrow-History
      def get_flexible_loan_borrow_history(**kwargs)
        @session.sign_request(:get, '/sapi/v2/loan/flexible/borrow/history', params: kwargs)
      end

      # Get Flexible Loan Ongoing Orders (USER_DATA)
      #
      # GET /sapi/v2/loan/flexible/ongoing/orders
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/user-information/Get-Flexible-Loan-Ongoing-Orders
      def get_flexible_loan_ongoing_orders(**kwargs)
        @session.sign_request(:get, '/sapi/v2/loan/flexible/ongoing/orders', params: kwargs)
      end

      # Get Flexible Loan Repayment History (USER_DATA)
      #
      # GET /sapi/v2/loan/flexible/repay/history
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/flexible-rate/user-information/Get-Flexible-Loan-Repayment-History
      def get_flexible_loan_repayment_history(**kwargs)
        @session.sign_request(:get, '/sapi/v2/loan/flexible/repay/history', params: kwargs)
      end

      # Get Crypto Loans Income History (USER_DATA)
      #
      # GET /sapi/v1/loan/income
      #
      # @param kwargs [Hash]
      # @param kwargs [String] :asset
      # @option kwargs [String] :type All types will be returned by default. Enum：borrowIn ,collateralSpent, repayAmount, collateralReturn(Collateral return after repayment), addCollateral
      #                          removeCollateral, collateralReturnAfterLiquidation
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 20, max 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/stable-rate/market-data/Get-Crypto-Loans-Income-History
      def get_loan_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/loan/income', params: kwargs)
      end

      # Get Loan Borrow History (USER_DATA)
      #
      # GET /sapi/v1/loan/borrow/history
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderId orderId in POST /sapi/v1/loan/borrow
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/stable-rate/user-information
      def get_loan_borrow_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/loan/borrow/history', params: kwargs)
      end

      # Get Loan LTV Adjustment History (USER_DATA)
      #
      # GET /sapi/v1/loan/ltv/adjustment/history
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderId
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/stable-rate/user-information/Get-Loan-LTV-Adjustment-History
      def get_loan_ltv_adjustment_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/loan/ltv/adjustment/history', params: kwargs)
      end

      # Get Loan Repayment History (USER_DATA)
      #
      # GET /sapi/v1/loan/repay/history
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :orderId
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Current querying page. Start from 1; default: 1; max: 1000
      # @option kwargs [Integer] :limit Default: 10; max: 100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/crypto_loan/stable-rate/user-information/Get-Loan-Repayment-History
      def get_loan_repayment_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/loan/repay/history', params: kwargs)
      end
    end
  end
end
