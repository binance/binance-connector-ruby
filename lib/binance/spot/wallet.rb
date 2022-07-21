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
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#all-coins-39-information-user_data
      def coin_info(**kwargs)
        @session.sign_request(:get, '/sapi/v1/capital/config/getall', params: kwargs)
      end

      # Daily Account Snapshot (USER_DATA)
      #
      # GET /sapi/v1/accountSnapshot
      #
      # @param type [String] "SPOT", "MARGIN", "FUTURES"
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit min 5, max 30, default 5
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#daily-account-snapshot-user_data
      def account_snapshot(type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:get, '/sapi/v1/accountSnapshot', params: kwargs.merge(
          type: type
        ))
      end

      # Disable Fast Withdraw Switch (USER_DATA)
      #
      # POST /sapi/v1/account/disableFastWithdrawSwitch
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#disable-fast-withdraw-switch-user_data
      def disable_fast_withdraw(**kwargs)
        @session.sign_request(:post, '/sapi/v1/account/disableFastWithdrawSwitch', params: kwargs)
      end

      # Enable Fast Withdraw Switch (USER_DATA)
      #
      # POST /sapi/v1/account/enableFastWithdrawSwitch
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#enable-fast-withdraw-switch-user_data
      def enable_fast_withdraw(**kwargs)
        @session.sign_request(:post, '/sapi/v1/account/enableFastWithdrawSwitch', params: kwargs)
      end

      # Withdraw [SAPI]
      #
      # POST /sapi/v1/capital/withdraw/apply
      #
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
      def withdraw(coin:, address:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)
        Binance::Utils::Validation.require_param('address', address)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/capital/withdraw/apply', params: kwargs.merge(
          coin: coin,
          address: address,
          amount: amount
        ))
      end

      # Deposit History (supporting network) (USER_DATA)
      #
      # GET /sapi/v1/capital/deposit/hisrec
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :status 0(0:pending,6: credited but cannot withdraw, 1:success)
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :offest Default:0
      # @option kwargs [Integer] :limit Default:1000, Max:1000
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#deposit-history-supporting-network-user_data
      def deposit_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/capital/deposit/hisrec', params: kwargs)
      end

      # Withdraw History (supporting network) (USER_DATA)
      #
      # GET /sapi/v1/capital/withdraw/history
      #
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
      def withdraw_history(**kwargs)
        @session.sign_request(:get, '/sapi/v1/capital/withdraw/history', params: kwargs)
      end

      # Deposit Address (supporting network) (USER_DATA)
      #
      # GET /sapi/v1/capital/deposit/address
      #
      # @param coin [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :network
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#withdraw-history-supporting-network-user_data
      def deposit_address(coin:, **kwargs)
        Binance::Utils::Validation.require_param('coin', coin)

        @session.sign_request(:get, '/sapi/v1/capital/deposit/address', params: kwargs.merge(
          coin: coin
        ))
      end

      # Account Status (USER_DATA)
      #
      # GET /sapi/v1/account/status
      #
      # Fetch account status detail.
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-status-user_data
      def account_status(**kwargs)
        @session.sign_request(:get, '/sapi/v1/account/status', params: kwargs)
      end

      # Account API Trading Status (USER_DATA)
      #
      # GET /sapi/v1/account/apiTradingStatus
      #
      # Fetch account api trading status detail.
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-api-trading-status-user_data
      def api_trading_status(**kwargs)
        @session.sign_request(:get, '/sapi/v1/account/apiTradingStatus', params: kwargs)
      end

      # DustLog (USER_DATA)
      #
      # GET /sapi/v1/asset/dribblet
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#dustlog-user_data
      def dust_log(**kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/dribblet', params: kwargs)
      end

      # Dust Transfer (USER_DATA)
      #
      # POST /sapi/v1/asset/dust
      #
      # Convert dust assets to BNB.
      #
      # @param asset [Array]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#dust-transfer-user_data
      def dust_transfer(asset:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)

        @session.sign_request(:post, '/sapi/v1/asset/dust', params: kwargs.merge(
          asset: asset
        ))
      end

      # Asset Dividend Record (USER_DATA)
      #
      # GET /sapi/v1/asset/assetDividend
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit Default 20, max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#asset-dividend-record-user_data
      def asset_devidend_record(**kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/assetDividend', params: kwargs)
      end

      # Asset Detail (USER_DATA)
      #
      # GET /sapi/v1/asset/assetDetail
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#asset-detail-user_data
      def asset_detail(**kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/assetDetail', params: kwargs)
      end

      # Trade Fee (USER_DATA)
      #
      # GET /sapi/v1/asset/tradeFee
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :symbol
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#trade-fee-user_data
      def trade_fee(**kwargs)
        @session.sign_request(:get, '/sapi/v1/asset/tradeFee', params: kwargs)
      end

      # User Universal Transfer (USER_DATA)
      #
      # POST /sapi/v1/asset/transfer
      #
      # @param type [String]
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :fromSymbol must be sent when type are ISOLATEDMARGIN_MARGIN and ISOLATEDMARGIN_ISOLATEDMARGIN
      # @option kwargs [String] :toSymbol must be sent when type are MARGIN_ISOLATEDMARGIN and ISOLATEDMARGIN_ISOLATEDMARGIN
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#user-universal-transfer-user_data
      def user_universal_transfer(type:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/asset/transfer', params: kwargs.merge(
          type: type,
          asset: asset,
          amount: amount
        ))
      end

      # Query User Universal Transfer History (USER_DATA)
      #
      # GET /sapi/v1/asset/transfer
      #
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
      def user_universal_transfer_history(type:, **kwargs)
        Binance::Utils::Validation.require_param('type', type)
        @session.sign_request(:get, '/sapi/v1/asset/transfer', params: kwargs.merge(type: type))
      end

      # Funding Wallet (USER_DATA)
      #
      # POST /sapi/v1/asset/get-funding-asset
      #
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [String] :needBtcValuation true or false
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#funding-wallet-user_data
      def funding_wallet(**kwargs)
        @session.sign_request(:post, '/sapi/v1/asset/get-funding-asset', params: kwargs)
      end

      # Get API Key Permission (USER_DATA)
      #
      # GET /sapi/v1/account/apiRestrictions
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-api-key-permission-user_data
      def api_key_permission(**kwargs)
        @session.sign_request(:get, '/sapi/v1/account/apiRestrictions', params: kwargs)
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
