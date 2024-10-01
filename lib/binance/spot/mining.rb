# frozen_string_literal: true

module Binance
  class Spot
    # Mining endpoints
    # The endpoints below allow to interact with Binance Pool.
    # @see https://developers.binance.com/docs/mining/Introduction
    module Mining
      # Acquiring Algorithm (MARKET_DATA)
      #
      # GET /sapi/v1/mining/pub/algoList
      #
      # @see https://developers.binance.com/docs/mining/rest-api/Acquiring-Algorithm
      def mining_algo_list
        @session.limit_request(path: '/sapi/v1/mining/pub/algoList')
      end

      # Acquiring CoinName (MARKET_DATA)
      #
      # GET /sapi/v1/mining/pub/coinList
      #
      # @see https://developers.binance.com/docs/mining/rest-api/Acquiring-CoinName
      def mining_coin_list
        @session.limit_request(path: '/sapi/v1/mining/pub/coinList')
      end

      # Request for Detail Miner List (USER_DATA)
      #
      # GET /sapi/v1/mining/worker/detail
      #
      # @param algo [String]
      # @param userName [String]
      # @param workerName [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Request-for-Detail-Miner-List
      def mining_worker(algo:, userName:, workerName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)
        Binance::Utils::Validation.require_param('workerName', workerName)

        @session.sign_request(:get, '/sapi/v1/mining/worker/detail', params: kwargs.merge(
          algo: algo,
          userName: userName,
          workerName: workerName
        ))
      end

      # Request for Miner List (USER_DATA)
      #
      # GET /sapi/v1/mining/worker/list
      #
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :pageIndex
      # @option kwargs [String] :sort
      # @option kwargs [String] :sortColumn
      # @option kwargs [String] :workerStatus
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Request-for-Miner-List
      def mining_worker_list(algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/worker/list', params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Earnings List(USER_DATA)
      #
      # GET /sapi/v1/mining/payment/list
      #
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startDate
      # @option kwargs [Integer] :endDate
      # @option kwargs [Integer] :pageIndex
      # @option kwargs [Integer] :pageSize
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Earnings-List
      def mining_revenue_list(algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/payment/list', params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Statistic List (USER_DATA)
      #
      # GET /sapi/v1/mining/statistics/user/status
      #
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Statistic-List
      def mining_statistics_list(algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/statistics/user/status', params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Account List (USER_DATA)
      #
      # GET /sapi/v1/mining/statistics/user/list
      #
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Account-List
      def mining_account_list(algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/statistics/user/list', params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Extra Bonus List (USER_DATA)
      #
      # GET /sapi/v1/mining/payment/other
      #
      # @param algo [String]
      # @param userName [String]
      # @param kwargs [Hash]
      # @option kwargs [String] :coin
      # @option kwargs [Integer] :startDate Search date, millisecond timestamp, while empty query all
      # @option kwargs [Integer] :endDate Search date, millisecond timestamp, while empty query all
      # @option kwargs [Integer] :pageIndex Page number, empty default first page, starting from 1
      # @option kwargs [Integer] :pageSize Number of pages, minimum 10, maximum 200
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Extra-Bonus-List
      def mining_extra_bonus(algo:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/payment/other', params: kwargs.merge(
          algo: algo,
          userName: userName
        ))
      end

      # Hashrate Resale List (USER_DATA)
      #
      # GET /sapi/v1/mining/hash-transfer/config/details/list
      #
      # @param kwargs [Hash]
      # @option kwargs [Integer] :pageIndex Page number, empty default first page, starting from 1
      # @option kwargs [Integer] :pageSize Number of pages, minimum 10, maximum 200
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Hashrate-Resale-List
      def mining_resale_list(**kwargs)
        @session.sign_request(:get, '/sapi/v1/mining/hash-transfer/config/details/list', params: kwargs)
      end

      # Hashrate Resale Detail (USER_DATA)
      #
      # GET /sapi/v1/mining/hash-transfer/profit/details
      #
      # @param configId [String] Mining ID
      # @param userName [String] Mining Account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :pageIndex Page number, empty default first page, starting from 1
      # @option kwargs [Integer] :pageSize Number of pages, minimum 10, maximum 200
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Hashrate-Resale-Detail
      def mining_resale_detail(configId:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('configId', configId)
        Binance::Utils::Validation.require_param('userName', userName)

        @session.sign_request(:get, '/sapi/v1/mining/hash-transfer/profit/details', params: kwargs.merge(
          configId: configId,
          userName: userName
        ))
      end

      # Hashrate Resale Request (USER_DATA)
      #
      # POST /sapi/v1/mining/hash-transfer/config
      #
      # @param userName [String] Mining Account
      # @param algo [String] Transfer algorithm(sha256)
      # @param startDate [Integer] Resale End Time (Millisecond timestamp)
      # @param endDate [Integer] Number of pages, minimum 10, maximum 200
      # @param toPoolUser [Integer] Mining Account
      # @param hashRate [Integer] Resale hashrate h/s must be transferred (BTC is greater than 500000000000 ETH is greater than 500000)
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Hashrate-Resale-Request
      def mining_resale_request(userName:, algo:, startDate:, endDate:, toPoolUser:, hashRate:, **kwargs)
        Binance::Utils::Validation.require_param('userName', userName)
        Binance::Utils::Validation.require_param('algo', algo)
        Binance::Utils::Validation.require_param('startDate', startDate)
        Binance::Utils::Validation.require_param('endDate', endDate)
        Binance::Utils::Validation.require_param('toPoolUser', toPoolUser)
        Binance::Utils::Validation.require_param('hashRate', hashRate)

        @session.sign_request(:post, '/sapi/v1/mining/hash-transfer/config', params: kwargs.merge(
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
      # @param configId [String] Mining ID
      # @param userName [String] Mining Account
      # @param kwargs [Hash]
      # @option kwargs [Integer] :recvWindow The value cannot be greater than 60000
      # @see https://developers.binance.com/docs/mining/rest-api/Cancel-hashrate-resale-configuration
      def mining_resale_cancel(configId:, userName:, **kwargs)
        Binance::Utils::Validation.require_param('userName', userName)
        Binance::Utils::Validation.require_param('configId', configId)

        @session.sign_request(:post, '/sapi/v1/mining/hash-transfer/config/cancel', params: kwargs.merge(
          configId: configId,
          userName: userName
        ))
      end
    end
  end
end
