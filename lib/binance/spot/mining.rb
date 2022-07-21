# frozen_string_literal: true

module Binance
  class Spot
    # Mining endpoints
    # The endpoints below allow to interact with Binance Pool.
    # @see https://binance-docs.github.io/apidocs/spot/en/#mining-endpoints
    module Mining
      # Acquiring Algorithm (MARKET_DATA)
      #
      # GET /sapi/v1/mining/pub/algoList
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#acquiring-algorithm-market_data
      def mining_algo_list
        @session.limit_request(path: '/sapi/v1/mining/pub/algoList')
      end

      # Acquiring CoinName (MARKET_DATA)
      #
      # GET /sapi/v1/mining/pub/coinList
      #
      # @see https://binance-docs.github.io/apidocs/spot/en/#acquiring-coinname-market_data
      def mining_coin_list
        @session.limit_request(path: '/sapi/v1/mining/pub/coinList')
      end

      # Request for Detail Miner List (USER_DATA)
      #
      # GET /sapi/v1/mining/worker/detail
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param algo [String]
      # @param userName [String]
      # @param workerName [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#request-for-detail-miner-list-user_data
      def mining_worker(timestamp = present_timestamp, algo:, userName:, workerName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)
        Binance::Utils::Validation.require_param('workerName', workerName)

        @session.sign_request(:get, '/sapi/v1/mining/worker/detail', timestamp, params: kwargs.merge(
          algo: algo,
          userName: userName,
          workerName: workerName
        ))
      end

      # Request for Miner List (USER_DATA)
      #
      # GET /sapi/v1/mining/worker/list
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :pageIndex
      # @option kwargs [String] :sort
      # @option kwargs [String] :sortColumn
      # @option kwargs [String] :workerStatus
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#request-for-miner-list-user_data
      def mining_worker_list(timestamp = present_timestamp, algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/worker/list', timestamp, params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Earnings List(USER_DATA)
      #
      # GET /sapi/v1/mining/payment/list
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startDate
      # @option kwargs [Integer] :endDate
      # @option kwargs [Integer] :pageIndex
      # @option kwargs [Integer] :pageSize
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#earnings-list-user_data
      def mining_revenue_list(timestamp = present_timestamp, algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/payment/list', timestamp, params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Statistic List (USER_DATA)
      #
      # GET /sapi/v1/mining/statistics/user/status
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#statistic-list-user_data
      def mining_statistics_list(timestamp = present_timestamp, algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/statistics/user/status', timestamp, params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Account List (USER_DATA)
      #
      # GET /sapi/v1/mining/statistics/user/list
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#account-list-user_data
      def mining_account_list(timestamp = present_timestamp, algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/statistics/user/list', timestamp, params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Extra Bonus List (USER_DATA)
      #
      # GET /sapi/v1/mining/payment/other
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startDate Search date, millisecond timestamp, while empty query all
      # @option kwargs [Integer] :endDate Search date, millisecond timestamp, while empty query all
      # @option kwargs [Integer] :pageIndex Page number, empty default first page, starting from 1
      # @option kwargs [Integer] :pageSize Number of pages, minimum 10, maximum 200
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#extra-bonus-list-user_data
      def mining_extra_bonus(timestamp = present_timestamp, algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/payment/other', timestamp, params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Hashrate Resale List (USER_DATA)
      #
      # GET /sapi/v1/mining/hash-transfer/config/details/list
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param kwargs [Hash]
      # @option kwargs [Integer] :pageIndex Page number, empty default first page, starting from 1
      # @option kwargs [Integer] :pageSize Number of pages, minimum 10, maximum 200
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#hashrate-resale-list-user_data
      def mining_resale_list(timestamp = present_timestamp, **kwargs)
        @session.sign_request(:get, '/sapi/v1/mining/hash-transfer/config/details/list', timestamp, params: kwargs)
      end

      # Hashrate Resale Detail (USER_DATA)
      #
      # GET /sapi/v1/mining/hash-transfer/profit/details
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param configId [String] Mining ID
      # @param userName [String] Mining Account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :pageIndex Page number, empty default first page, starting from 1
      # @option kwargs [Integer] :pageSize Number of pages, minimum 10, maximum 200
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#hashrate-resale-detail-user_data
      def mining_resale_detail(timestamp = present_timestamp, configId:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('configId', configId)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/hash-transfer/profit/details', timestamp, params: kwargs.merge(
          configId: configId,
          userName: userName
        ))
      end

      # Hashrate Resale Request (USER_DATA)
      #
      # POST /sapi/v1/mining/hash-transfer/config
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param userName [String] Mining Account
      # @param algo [String] Transfer algorithm(sha256)
      # @param startDate [Integer] Resale End Time (Millisecond timestamp)
      # @param endDate [Integer] Number of pages, minimum 10, maximum 200
      # @param toPoolUser [Integer] Mining Account
      # @param hashRate [Integer] Resale hashrate h/s must be transferred (BTC is greater than 500000000000 ETH is greater than 500000)
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#hashrate-resale-request-user_data
      def mining_resale_request(timestamp = present_timestamp, userName:, algo:, startDate:, endDate:, toPoolUser:, hashRate:, **kwargs)
        Binance::Utils::Validation.require_param('userName', userName)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('startDate', startDate)
        Binance::Utils::Validation.require_param('endDate', endDate)
        Binance::Utils::Validation.require_param('toPoolUser', toPoolUser)
        Binance::Utils::Validation.require_param('hashRate', hashRate)

        @session.sign_request(:post, '/sapi/v1/mining/hash-transfer/config', timestamp, params: kwargs.merge(
          userName: userName,
          algo: algo,
          startDate: startDate,
          endDate: endDate,
          toPoolUser: toPoolUser,
          hashRate: hashRate
        ))
      end

      # Cancel hashrate resale configuration(USER_DATA)
      #
      # POST /sapi/v1/mining/hash-transfer/config/cancel
      #
      # @param timestamp [String] Number of milliseconds since 1970-01-01 00:00:00 UTC
      # @param configId [String] Mining ID
      # @param userName [String] Mining Account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://binance-docs.github.io/apidocs/spot/en/#cancel-hashrate-resale-configuration-user_data
      def mining_resale_cancel(timestamp = present_timestamp, configId:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('userName', userName)
        Binance::Utils::Validation.require_param('configId', configId)

        @session.sign_request(:post, '/sapi/v1/mining/hash-transfer/config/cancel', timestamp, params: kwargs.merge(
          configId: configId,
          userName: userName
        ))
      end
    end
  end
end
