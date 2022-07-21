# frozen_string_literal: true

module Binance
  class Spot
    # all sub-account endpoints
    # @see https://binance-docs.github.io/apidocs/spot/en/#sub-account-endpoints
    module Subaccount
      # Create a Virtual Sub-account(For Master Account)
      #
      # POST /sapi/v1/sub-account/virtualSubAccount
      #
      # This request will generate a virtual sub account under your master account.<br>
      # You need to enable "trade" option for the api key which requests this endpoint.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param subAccountString [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#create-a-virtual-sub-account-for-master-account
      def create_virtual_sub_account(timestamp = present_timestamp, subAccountString:, **kwargs)
        Binance::Utils::Validation.require_param('subAccountString', subAccountString)

        @session.sign_request(:post, '/sapi/v1/sub-account/virtualSubAccount', timestamp, params: kwargs.merge(
          subAccountString: subAccountString
        ))
      end

      # Query Sub-account List (For Master Account)
      #
      # GET /sapi/v1/sub-account/list
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :email Sub-account email
      # @option kwargs [String] :isFreeze true or false
      # @option kwargs [Integer] :page
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-sub-account-list-for-master-account
      def get_sub_account_list(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/list', timestamp, params: kwargs)
      end

      # Query Sub-account Spot Asset Transfer History (For Master Account)
      #
      # GET /sapi/v1/sub-account/sub/transfer/history
      #
      # fromEmail and toEmail cannot be sent at the same time.<br>
      # Return fromEmail equal master account email by default.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :fromEmail Sub-account email
      # @option kwargs [String] :toEmail Sub-account email
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :page Default value: 1
      # @option kwargs [Integer] :limit Default value: 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-sub-account-spot-asset-transfer-history-for-master-account
      def get_sub_account_spot_transfer_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/sub/transfer/history', timestamp, params: kwargs)
      end

      # Query Sub-account Futures Asset Transfer History (For Master Account)
      #
      # GET /sapi/v1/sub-account/futures/internalTransfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param futuresType [Integer] 1:USDT-margined Futures, 2: Coin-margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :startTime Default return the history with in 100 days
      # @option kwargs [Integer] :endTime Default return the history with in 100 days
      # @option kwargs [Integer] :page Default value: 1
      # @option kwargs [Integer] :limit Default value: 50, Max value: 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-sub-account-futures-asset-transfer-history-for-master-account
      def get_sub_account_futures_transfer_history(timestamp = present_timestamp, email:, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v1/sub-account/futures/internalTransfer', timestamp, params: kwargs.merge(
          email: email,
          futuresType: futuresType
        ))
      end

      # Sub-account Futures Asset Transfer (For Master Account)
      #
      # POST /sapi/v1/sub-account/futures/internalTransfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param fromEmail [String]
      # @param toEmail [String]
      # @param futuresType [Integer] 1:USDT-margined Futures, 2: Coin-margined Futures
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#sub-account-futures-asset-transfer-for-master-account
      def sub_account_futures_internal_transfer(timestamp = present_timestamp, fromEmail:, toEmail:, futuresType:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('fromEmail', fromEmail)
        Binance::Utils::Validation.require_param('toEmail', toEmail)
        Binance::Utils::Validation.require_param('futuresType', futuresType)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/futures/internalTransfer', timestamp, params: kwargs.merge(
          fromEmail: fromEmail,
          toEmail: toEmail,
          futuresType: futuresType,
          asset: asset,
          amount: amount
        ))
      end

      # Query Sub-account Assets (For Master Account)
      #
      # GET /sapi/v3/sub-account/assets
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-sub-account-assets-for-master-account
      def get_sub_account_assets(timestamp = present_timestamp, email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v3/sub-account/assets', timestamp, params: kwargs.merge(email: email))
      end

      # Query Sub-account Spot Assets Summary (For Master Account)
      #
      # GET /sapi/v1/sub-account/spotSummary
      #
      # Get BTC valued asset summary of subaccounts.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :email
      # @option kwargs [Integer] :page Default value: 1
      # @option kwargs [Integer] :size default 10, max 20
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-sub-account-spot-assets-summary-for-master-account
      def get_sub_account_spot_summary(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/spotSummary', timestamp, params: kwargs)
      end

      # Get Sub-account Deposit Address (For Master Account)
      #
      # GET /sapi/v1/capital/deposit/subAddress
      #
      # Fetch sub-account deposit address
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param coin [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :network
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-sub-account-deposit-address-for-master-account
      def sub_account_deposit_address(timestamp = present_timestamp, email:, coin:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('coin', coin)

        @session.sign_request(:get, '/sapi/v1/capital/deposit/subAddress', timestamp, params: kwargs.merge(
          email: email,
          coin: coin
        ))
      end

      # Get Sub-account Deposit History (For Master Account)
      #
      # GET /sapi/v1/capital/deposit/subHisrec
      #
      # Fetch sub-account deposit history
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [String] :status
      # @option kwargs [String] :startTime
      # @option kwargs [String] :endTime
      # @option kwargs [String] :limit
      # @option kwargs [String] :offset
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-sub-account-deposit-history-for-master-account
      def sub_account_deposit_history(timestamp = present_timestamp, email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/capital/deposit/subHisrec', timestamp, params: kwargs.merge(
          email: email
        ))
      end

      # Get Sub-account's Status on Margin/Futures(For Master Account)
      #
      # GET /sapi/v1/sub-account/status
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :email
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-sub-account-39-s-status-on-margin-futures-for-master-account
      def sub_account_status(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/status', timestamp, params: kwargs)
      end

      # Enable Margin for Sub-account (For Master Account)
      #
      # POST /sapi/v1/sub-account/margin/enable
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :email
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-sub-account-39-s-status-on-margin-futures-for-master-account
      def sub_account_enable_margin(timestamp = present_timestamp, email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:post, '/sapi/v1/sub-account/margin/enable', timestamp, params: kwargs.merge(
          email: email
        ))
      end

      # Get Detail on Sub-account's Margin Account (For Master Account)
      #
      # GET /sapi/v1/sub-account/margin/account
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-detail-on-sub-account-39-s-margin-account-for-master-account
      def sub_account_margin_account(timestamp = present_timestamp, email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/sub-account/margin/account', timestamp, params: kwargs.merge(
          email: email
        ))
      end

      # Get Summary of Sub-account's Margin Account (For Master Account)
      #
      # GET /sapi/v1/sub-account/margin/accountSummary
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-summary-of-sub-account-39-s-margin-account-for-master-account
      def sub_account_margin_account_summary(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/margin/accountSummary', timestamp, params: kwargs)
      end

      # Enable Futures for Sub-account (For Master Account)
      #
      # POST /sapi/v1/sub-account/futures/enable
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#enable-futures-for-sub-account-for-master-account
      def sub_account_enable_futures(timestamp = present_timestamp, email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:post, '/sapi/v1/sub-account/futures/enable', timestamp, params: kwargs.merge(
          email: email
        ))
      end

      # Get Detail on Sub-account's Futures Account (For Master Account)
      #
      # GET /sapi/v2/sub-account/futures/account
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param futuresType [Integer] 1:USDT Margined Futures, 2:COIN Margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-detail-on-sub-account-39-s-futures-account-v2-for-master-account
      def sub_account_futures_account(timestamp = present_timestamp, email:, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v2/sub-account/futures/account', timestamp, params: kwargs.merge(
          email: email,
          futuresType: futuresType
        ))
      end

      # Get Summary of Sub-account's Futures Account (For Master Account)
      #
      # GET /sapi/v2/sub-account/futures/accountSummary
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param futuresType [Integer] 1:USDT Margined Futures, 2:COIN Margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :page  default:1
      # @option kwargs [Integer] :limit default:10, max:20
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-summary-of-sub-account-39-s-futures-account-v2-for-master-account
      def sub_account_futures_account_summary(timestamp = present_timestamp, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v2/sub-account/futures/accountSummary', timestamp, params: kwargs.merge(
          futuresType: futuresType
        ))
      end

      # Get Futures Position-Risk of Sub-account (For Master Account)
      #
      # GET /sapi/v2/sub-account/futures/positionRisk
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param futuresType [Integer] 1:USDT Margined Futures, 2:COIN Margined Futures
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-futures-position-risk-of-sub-account-v2-for-master-account
      def sub_account_futures_position_risk(timestamp = present_timestamp, email:, futuresType:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('futuresType', futuresType)

        @session.sign_request(:get, '/sapi/v2/sub-account/futures/positionRisk', timestamp, params: kwargs.merge(
          email: email,
          futuresType: futuresType
        ))
      end

      # Futures Transfer for Sub-account(For Master Account)
      #
      # POST /sapi/v1/sub-account/futures/transfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer] 1: transfer from subaccount's spot account to its USDT-margined futures account<br>
      #    2: transfer from subaccount's USDT-margined futures account to its spot account<br>
      #    3: transfer from subaccount's spot account to its COIN-margined futures account<br>
      #    4:transfer from subaccount's COIN-margined futures account to its spot account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#futures-transfer-for-sub-account-for-master-account
      def sub_account_futures_transfer(timestamp = present_timestamp, email:, asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/sub-account/futures/transfer', timestamp, params: kwargs.merge(
          email: email,
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Margin Transfer for Sub-account(For Master Account)
      #
      # POST /sapi/v1/sub-account/margin/transfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param asset [String]
      # @param amount [Float]
      # @param type [Integer] 1: transfer from subaccount's spot account to margin account<br>
      #    2: transfer from subaccount's margin account to its spot account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#margin-transfer-for-sub-account-for-master-account
      def sub_account_margin_transfer(timestamp = present_timestamp, email:, asset:, amount:, type:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)
        Binance::Utils::Validation.require_param('type', type)

        @session.sign_request(:post, '/sapi/v1/sub-account/margin/transfer', timestamp, params: kwargs.merge(
          email: email,
          asset: asset,
          amount: amount,
          type: type
        ))
      end

      # Transfer to Sub-account of Same Master(For Sub-account)
      #
      # POST /sapi/v1/sub-account/transfer/subToSub
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param toEmail [String]
      # @param asset [String]
      # @param amount [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#transfer-to-sub-account-of-same-master-for-sub-account
      def sub_account_transfer_to_sub(timestamp = present_timestamp, toEmail:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('toEmail', toEmail)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/transfer/subToSub', timestamp, params: kwargs.merge(
          toEmail: toEmail,
          asset: asset,
          amount: amount
        ))
      end

      # Transfer to Sub-account of Same Master(For Sub-account)
      #
      # POST /sapi/v1/sub-account/transfer/subToMaster
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#transfer-to-master-for-sub-account
      def sub_account_transfer_to_master(timestamp = present_timestamp, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/transfer/subToMaster', timestamp, params: kwargs.merge(
          asset: asset,
          amount: amount
        ))
      end

      # Sub-account Transfer History (For Sub-account)
      #
      # GET /sapi/v1/sub-account/transfer/subUserHistory
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :asset
      # @option kwargs [Integer] :type 1: transfer in, 2: transfer out
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :limit
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#sub-account-transfer-history-for-sub-account
      def sub_account_transfer_sub_account_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/transfer/subUserHistory', timestamp, params: kwargs)
      end

      # Universal Transfer (For Master Account)
      #
      # POST /sapi/v1/sub-account/universalTransfer
      #
      # You need to enable "internal transfer" option for the api key which requests this endpoint.<br>
      # Transfer between futures accounts is not supported.
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param fromAccountType [String] "SPOT","USDT_FUTURE","COIN_FUTURE"
      # @param toAccountType [String] "SPOT","USDT_FUTURE","COIN_FUTURE"
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [String] :fromEmail Transfer from master account by default if fromEmail is not sent.
      # @option kwargs [String] :toEmail Transfer to master account by default if toEmail is not sent.
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#universal-transfer-for-master-account
      def universal_transfer(timestamp = present_timestamp, fromAccountType:, toAccountType:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('fromAccountType', fromAccountType)
        Binance::Utils::Validation.require_param('toAccountType', toAccountType)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/sub-account/universalTransfer', timestamp, params: kwargs.merge(
          fromAccountType: fromAccountType,
          toAccountType: toAccountType,
          asset: asset,
          amount: amount
        ))
      end

      # Query Universal Transfer History (For Master Account)
      #
      # GET /sapi/v1/sub-account/universalTransfer
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [String] :fromEmail
      # @option kwargs [String] :toEmail
      # @option kwargs [Integer] :startTime
      # @option kwargs [Integer] :endTime
      # @option kwargs [Integer] :page
      # @option kwargs [Integer] :limit Default 500, Max 500
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-universal-transfer-history-for-master-account
      def universal_transfer_history(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/sub-account/universalTransfer', timestamp, params: kwargs)
      end

      # Enable Leverage Token for Sub-account (For Master Account)
      #
      # POST /sapi/v1/sub-account/blvt/enable
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param enableBlvt [Boolean] Only true for now
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#enable-leverage-token-for-sub-account-for-master-account
      def sub_account_enable_blvt(timestamp = present_timestamp, email:, enableBlvt:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('enableBlvt', enableBlvt)

        @session.sign_request(:post, '/sapi/v1/sub-account/blvt/enable', timestamp, params: kwargs.merge(
          email: email,
          enableBlvt: enableBlvt
        ))
      end

      # Deposit assets into the managed sub-account (For Investor Master Account)
      #
      # POST /sapi/v1/managed-subaccount/deposit
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param toEmail [String]
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#deposit-assets-into-the-managed-sub-account-for-investor-master-account
      def deposit_to_sub_account(timestamp = present_timestamp, toEmail:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('toEmail', toEmail)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/managed-subaccount/deposit', timestamp, params: kwargs.merge(
          toEmail: toEmail,
          asset: asset,
          amount: amount
        ))
      end

      # Query managed sub-account asset details (For Investor Master Account)
      #
      # GET /sapi/v1/managed-subaccount/asset
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param email [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#query-managed-sub-account-asset-details-for-investor-master-account
      def sub_account_asset_details(timestamp = present_timestamp, email:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)

        @session.sign_request(:get, '/sapi/v1/managed-subaccount/asset', timestamp, params: kwargs.merge(email: email))
      end

      # Withdrawl assets from the managed sub-account (For Investor Master Account)
      #
      # POST /sapi/v1/managed-subaccount/withdraw
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param fromEmail  [String]
      # @param asset [String]
      # @param amount [Float]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :transferDate
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#withdrawl-assets-from-the-managed-sub-account-for-investor-master-account
      def withdraw_from_sub_account(timestamp = present_timestamp, fromEmail:, asset:, amount:, **kwargs)
        Binance::Utils::Validation.require_param('fromEmail', fromEmail)
        Binance::Utils::Validation.require_param('asset', asset)
        Binance::Utils::Validation.require_param('amount', amount)

        @session.sign_request(:post, '/sapi/v1/managed-subaccount/withdraw', timestamp, params: kwargs.merge(
          fromEmail: fromEmail,
          asset: asset,
          amount: amount
        ))
      end

      # Enable or Disable IP Restriction for a Sub-account API Key (For Master Account)
      #
      # POST /sapi/v1/sub-account/subAccountApi/ipRestriction
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @param ipRestrict [Boolean]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#enable-or-disable-ip-restriction-for-a-sub-account-api-key-for-master-account
      def sub_account_toggle_ip_restriction(email:, subAccountApiKey:, ipRestrict:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)
        Binance::Utils::Validation.require_param('ipRestrict', ipRestrict)

        @session.sign_request(:post, '/sapi/v1/sub-account/subAccountApi/ipRestriction', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey,
          ipRestrict: ipRestrict
        ))
      end

      # Add IP List for a Sub-account API Key (For Master Account)
      #
      # POST /sapi/v1/sub-account/subAccountApi/ipRestriction/ipList
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @param ipAddress [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#add-ip-list-for-a-sub-account-api-key-for-master-account
      def sub_account_add_ip_list(email:, subAccountApiKey:, ipAddress:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)
        Binance::Utils::Validation.require_param('ipAddress', ipAddress)

        @session.sign_request(:post, '/sapi/v1/sub-account/subAccountApi/ipRestriction/ipList', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey,
          ipAddress: ipAddress
        ))
      end

      # Get IP Restriction for a Sub-account API Key (For Master Account)
      #
      # GET /sapi/v1/sub-account/subAccountApi/ipRestriction
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-ip-restriction-for-a-sub-account-api-key-for-master-account
      def sub_account_ip_list(email:, subAccountApiKey:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)

        @session.sign_request(:get, '/sapi/v1/sub-account/subAccountApi/ipRestriction', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey
        ))
      end

      # Delete IP List For a Sub-account API Key (For Master Account)
      #
      # DELETE /sapi/v1/sub-account/subAccountApi/ipRestriction/ipList
      #
      # @param email  [String]
      # @param subAccountApiKey [String]
      # @param ipAddress [String]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#get-ip-restriction-for-a-sub-account-api-key-for-master-account
      def sub_account_delete_ip_list(email:, subAccountApiKey:, ipAddress:, **kwargs)
        Binance::Utils::Validation.require_param('email', email)
        Binance::Utils::Validation.require_param('subAccountApiKey', subAccountApiKey)
        Binance::Utils::Validation.require_param('ipAddress', ipAddress)

        @session.sign_request(:delete, '/sapi/v1/sub-account/subAccountApi/ipRestriction/ipList', params: kwargs.merge(
          email: email,
          subAccountApiKey: subAccountApiKey,
          ipAddress: ipAddress
        ))
      end
    end
  end
end
