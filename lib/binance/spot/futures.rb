# frozen_string_literal: true

module Binance
  class Spot
    # Futures endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#futures
    module Futures
      # New Future Account Transfer (USER_DATA)
      #
      # POST /sapi/v1/futures/transfer
      #
      # Execute transfer between spot account and futures account.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer] 1: transfer from spot account to USDT-M futures account. <br>
      #   2: transfer from USDT-M futures account to spot account. <br>
      #   3: transfer from spot account to COIN-M futures account. <br>
      #   4: transfer from COIN-M futures account to spot account. <br>
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#new-future-account-transfer-user_data
      def futures_account_transfer(timestamp = present_timestamp, asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/futures/transfer', timestamp, params: kwargs.merge(
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Get Future Account Transaction History List (USER_DATA)
      #
      # GET /sapi/v1/futures/transfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param asset [String]
      # @param startTime [Integer]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :size Default:10 Max:100
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-future-account-transaction-history-list-user_data
      def futures_account_transfer_history(timestamp = present_timestamp, asset:, startTime:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('startTime', startTime)

        @session.sign_request(:get, '/sapi/v1/futures/transfer', timestamp, params: kwargs.merge(
          asset: asset,
          startTime: startTime
        ))
      end

      # Borrow For Cross-Collateral (TRADE)
      #
      # POST /sapi/v1/futures/loan/borrow
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param coin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Float] :amount Mandatory when collateralAmount is empty.
      # @option kwargs [Float] :collateralAmount Mandatory when amount is empty.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#borrow-for-cross-collateral-trade
      def cross_collateral_borrow(timestamp = present_timestamp, coin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)

        @session.sign_request(:post, '/sapi/v1/futures/loan/borrow', timestamp, params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin
        ))
      end

      # Cross-Collateral Borrow History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/borrow/history
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-borrow-history-user_data
      def cross_collateral_borrow_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/futures/loan/borrow/history', timestamp, params: kwargs)
      end

      # Repay For Cross-Collateral (TRADE)
      #
      # POST /sapi/v1/futures/loan/repay
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param coin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#repay-for-cross-collateral-trade
      def cross_collateral_repay(timestamp = present_timestamp, coin:, collateralCoin:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/futures/loan/repay', timestamp, params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin,
          amount: amount
        ))
      end

      # Cross-Collateral Repayment History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/repay/history
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-repayment-history-user_data
      def cross_collateral_repay_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/futures/loan/repay/history', timestamp, params: kwargs)
      end

      # Cross-Collateral Wallet (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/wallet
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-wallet-v2-user_data
      def cross_collateral_wallet(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v2/futures/loan/wallet', timestamp, params: kwargs)
      end

      # Cross-Collateral Information (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/configs
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-information-v2-user_data
      def cross_collateral_info(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v2/futures/loan/configs', timestamp, params: kwargs)
      end

      # Calculate Rate After Adjust Cross-Collateral LTV (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/calcAdjustLevel
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param direction [String] "ADDITIONAL", "REDUCED"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#calculate-rate-after-adjust-cross-collateral-ltv-v2-user_data
      def calculate_adjust_rate(timestamp = present_timestamp, loanCoin:, collateralCoin:, amount:, direction:, **kwargs)
        Binance::Utils::Validation.require_param('loanCoin', loanCoin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('direction', direction)

        @session.sign_request(:get, '/sapi/v2/futures/loan/calcAdjustLevel', timestamp, params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin,
          amount: amount,
          direction: direction
        ))
      end

      # Get Max Amount for Adjust Cross-Collateral LTV (USER_DATA)
      #
      # GET /sapi/v2/futures/loan/calcMaxAdjustAmount
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-max-amount-for-adjust-cross-collateral-ltv-v2-user_data
      def calculate_adjust_max_amount(timestamp = present_timestamp, loanCoin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param('loanCoin', loanCoin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)

        @session.sign_request(:get, '/sapi/v2/futures/loan/calcMaxAdjustAmount', timestamp, params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin
        ))
      end

      # Adjust Cross-Collateral LTV (TRADE)
      #
      # POST /sapi/v2/futures/loan/adjustCollateral
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param loanCoin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param direction [String] "ADDITIONAL", "REDUCED"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#adjust-cross-collateral-ltv-v2-trade
      def adjust_cross_collateral(timestamp = present_timestamp, loanCoin:, collateralCoin:, amount:, direction:, **kwargs)
        Binance::Utils::Validation.require_param('loanCoin', loanCoin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('direction', direction)

        @session.sign_request(:post, '/sapi/v2/futures/loan/adjustCollateral', timestamp, params: kwargs.merge(
          loanCoin: loanCoin,
          collateralCoin: collateralCoin,
          amount: amount,
          direction: direction
        ))
      end

      # Adjust Cross-Collateral LTV History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/adjustCollateral/history
      #
      # All data will be returned if loanCoin or collateralCoin is not sent
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#adjust-cross-collateral-ltv-history-user_data
      def adjust_cross_collateral_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/futures/loan/adjustCollateral/history', timestamp, params: kwargs)
      end

      # Cross-Collateral Liquidation History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/liquidationHistory
      #
      # All data will be returned if loanCoin or collateralCoin is not sent
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :loanCoin
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-liquidation-history-user_data
      def cross_collateral_liquidation_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/futures/loan/liquidationHistory', timestamp, params: kwargs)
      end

      # Check Collateral Repay Limit (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/collateralRepayLimit
      #
      # Check the maximum and minimum limit when repay with collateral.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param coin [String]
      # @param collateralCoin [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#check-collateral-repay-limit-user_data
      def collateral_repay_limit(timestamp = present_timestamp, coin:, collateralCoin:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)

        @session.sign_request(:get, '/sapi/v1/futures/loan/collateralRepayLimit', timestamp, params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin
        ))
      end

      # Get Collateral Repay Quote (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/collateralRepay
      #
      # Get quote before repay with collateral is mandatory, the quote will be valid within 25 seconds.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param coin [String]
      # @param collateralCoin [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-collateral-repay-quote-user_data
      def collateral_repay_quote(timestamp = present_timestamp, coin:, collateralCoin:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)
        Binance::Utils::Validation.require_param('collateralCoin', collateralCoin)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:get, '/sapi/v1/futures/loan/collateralRepay', timestamp, params: kwargs.merge(
          coin: coin,
          collateralCoin: collateralCoin,
          amount: amount
        ))
      end

      # Repay with Collateral (USER_DATA)
      #
      # POST /sapi/v1/futures/loan/collateralRepay
      #
      # Repay with collateral. Get quote before repay with collateral is mandatory, the quote will be valid within 25 seconds.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param quoteId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#repay-with-collateral-user_data
      def repay_with_collateral(timestamp = present_timestamp, quoteId:, **kwargs)
        Binance::Utils::Validation.require_param('quoteId', quoteId)

        @session.sign_request(:post, '/sapi/v1/futures/loan/collateralRepay', timestamp, params: kwargs.merge(
          quoteId: quoteId
        ))
      end

      # Collateral Repayment Result (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/collateralRepayResult
      #
      # Check collateral repayment result.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param quoteId [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#collateral-repayment-result-user_data
      def repayment_result(timestamp = present_timestamp, quoteId:, **kwargs)
        Binance::Utils::Validation.require_param('quoteId', quoteId)

        @session.sign_request(:get, '/sapi/v1/futures/loan/collateralRepayResult', timestamp, params: kwargs.merge(
          quoteId: quoteId
        ))
      end

      # Cross-Collateral Interest History (USER_DATA)
      #
      # GET /sapi/v1/futures/loan/interestHistory
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :collateralCoin
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Currently querying page. Start from 1. Default:1
      # @option kwargs [Integer] :limit default 500, max 1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cross-collateral-interest-history-user_data
      def cross_collateral_interest_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/futures/loan/interestHistory', timestamp, params: kwargs)
      end
    end
  end
end
