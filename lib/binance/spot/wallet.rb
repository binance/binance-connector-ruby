# frozen_string_literal: true

module Binance
  class Spot
    # all wallet endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#wallet-endpoints
    module Wallet
      # System Status (System)
      #
      # GET /sapi/v1/system/status
      #
      # Fetch system status.
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#system-status-system
      def system_status
        @session.public_request(path: '/sapi/v1/system/status')
      end

      # All Coins' Information (USER_DATA)
      #
      # GET /sapi/v1/capital/config/getall
      #
      # Get information of coins (available for deposit and withdraw) for user.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#all-coins-39-information-user_data
      def coin_info(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/capital/config/getall', timestamp, params: kwargs)
      end

      # Daily Account Snapshot (USER_DATA)
      #
      # GET /sapi/v1/accountSnapshot
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param type [String] "SPOT", "MARGIN", "FUTURES"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit min 5, max 30, default 5
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#daily-account-snapshot-user_data
      def account_snapshot(timestamp = present_timestamp, type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/accountSnapshot', timestamp, params: kwargs.merge(
          type: type
        ))
      end

      # Disable Fast Withdraw Switch (USER_DATA)
      #
      # POST /sapi/v1/account/disableFastWithdrawSwitch
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#disable-fast-withdraw-switch-user_data
      def disable_fast_withdraw(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:post, '/sapi/v1/account/disableFastWithdrawSwitch', timestamp, params: kwargs)
      end

      # Enable Fast Withdraw Switch (USER_DATA)
      #
      # POST /sapi/v1/account/enableFastWithdrawSwitch
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#enable-fast-withdraw-switch-user_data
      def enable_fast_withdraw(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:post, '/sapi/v1/account/enableFastWithdrawSwitch', timestamp, params: kwargs)
      end

      # Withdraw [SAPI]
      #
      # POST /sapi/v1/capital/withdraw/apply
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param coin [String]
      # @param address [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :withdrawOrderId
      # @option kwargs [String] :network If network not send, return with default network of the coin.
      # @option kwargs [String] :addressTag
      # @option kwargs [Boolean] :transactionFeeFlag
      # @option kwargs [String] :name
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#withdraw-sapi
      def withdraw(timestamp = present_timestamp, coin:, address:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)
        Binance::Utils::Validation.require_param('address', address)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/capital/withdraw/apply', timestamp, params: kwargs.merge(
          coin: coin,
          address: address,
          amount: amount
        ))
      end

      # Deposit History (supporting network) (USER_DATA)
      #
      # GET /sapi/v1/capital/deposit/hisrec
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :status 0(0:pending,6: credited but cannot withdraw, 1:success)
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :offest Default:0
      # @option kwargs [Integer] :limit Default:1000, Max:1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#deposit-history-supporting-network-user_data
      def deposit_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/capital/deposit/hisrec', timestamp, params: kwargs)
      end

      # Withdraw History (supporting network) (USER_DATA)
      #
      # GET /sapi/v1/capital/withdraw/history
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [String] :withdrawOrderId
      # @option kwargs [Integer] :status 0(0:pending,6: credited but cannot withdraw, 1:success)
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :offest
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#withdraw-history-supporting-network-user_data
      def withdraw_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/capital/withdraw/history', timestamp, params: kwargs)
      end

      # Deposit Address (supporting network) (USER_DATA)
      #
      # GET /sapi/v1/capital/deposit/address
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param coin [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :network
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#withdraw-history-supporting-network-user_data
      def deposit_address(timestamp = present_timestamp, coin:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)

        @session.sign_request(:get, '/sapi/v1/capital/deposit/address', timestamp, params: kwargs.merge(
          coin: coin
        ))
      end

      # Account Status (USER_DATA)
      #
      # GET /sapi/v1/account/status
      #
      # Fetch account status detail.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-status-user_data
      def account_status(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/account/status', timestamp, params: kwargs)
      end

      # Account API Trading Status (USER_DATA)
      #
      # GET /sapi/v1/account/apiTradingStatus
      #
      # Fetch account api trading status detail.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-api-trading-status-user_data
      def api_trading_status(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/account/apiTradingStatus', timestamp, params: kwargs)
      end

      # DustLog (USER_DATA)
      #
      # GET /sapi/v1/asset/dribblet
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#dustlog-user_data
      def dust_log(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/dribblet', timestamp, params: kwargs)
      end

      # Dust Transfer (USER_DATA)
      #
      # POST /sapi/v1/asset/dust
      #
      # Convert dust assets to BNB.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param asset [Array]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#dust-transfer-user_data
      def dust_transfer(timestamp = present_timestamp, asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:post, '/sapi/v1/asset/dust', timestamp, params: kwargs.merge(
          asset: asset
        ))
      end

      # Asset Dividend Record (USER_DATA)
      #
      # GET /sapi/v1/asset/assetDividend
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit Default 20, max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#asset-dividend-record-user_data
      def asset_devidend_record(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/assetDividend', timestamp, params: kwargs)
      end

      # Asset Detail (USER_DATA)
      #
      # GET /sapi/v1/asset/assetDetail
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#asset-detail-user_data
      def asset_detail(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/assetDetail', timestamp, params: kwargs)
      end

      # Trade Fee (USER_DATA)
      #
      # GET /sapi/v1/asset/tradeFee
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#trade-fee-user_data
      def trade_fee(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/tradeFee', timestamp, params: kwargs)
      end

      # User Universal Transfer (USER_DATA)
      #
      # POST /sapi/v1/asset/transfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param type [String]
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :fromSymbol must be sent when type are ISOLATEDMARGIN_MARGIN and ISOLATEDMARGIN_ISOLATEDMARGIN
      # @option kwargs [String] :toSymbol must be sent when type are MARGIN_ISOLATEDMARGIN and ISOLATEDMARGIN_ISOLATEDMARGIN
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#user-universal-transfer-user_data
      def user_universal_transfer(timestamp = present_timestamp, type:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/asset/transfer', timestamp, params: kwargs.merge(
          type: type,
          asset: asset,
          amount: amount
        ))
      end

      # Query User Universal Transfer History (USER_DATA)
      #
      # GET /sapi/v1/asset/transfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param type [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :current Default 1
      # @option kwargs [Integer] :size Default 10, Max 100
      # @option kwargs [String] :fromSymbol must be sent when type are ISOLATEDMARGIN_MARGIN and ISOLATEDMARGIN_ISOLATEDMARGIN
      # @option kwargs [String] :toSymbol must be sent when type are MARGIN_ISOLATEDMARGIN and ISOLATEDMARGIN_ISOLATEDMARGIN
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-user-universal-transfer-history-user_data
      def user_universal_transfer_history(timestamp = present_timestamp, type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)
        @session.sign_request(:get, '/sapi/v1/asset/transfer', timestamp, params: kwargs.merge(type: type))
      end

      # Funding Wallet (USER_DATA)
      #
      # POST /sapi/v1/asset/get-funding-asset
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :needBtcValuation true or false
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#funding-wallet-user_data
      def funding_wallet(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:post, '/sapi/v1/asset/get-funding-asset', timestamp, params: kwargs)
      end

      # Get API Key Permission (USER_DATA)
      #
      # GET /sapi/v1/account/apiRestrictions
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-api-key-permission-user_data
      def api_key_permission(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/account/apiRestrictions', timestamp, params: kwargs)
      end

      # User Asset (USER_DATA)
      #
      # POST /sapi/v3/asset/getUserAsset
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset If asset is blank, then query all positive assets user have.
      # @option kwargs [Boolean] :needBtcValuation
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#user-asset-user_data
      def get_user_asset(**kwargs)
        @session.sign_request(:post, '/sapi/v3/asset/getUserAsset', params: kwargs)
      end
    end
  end
end
