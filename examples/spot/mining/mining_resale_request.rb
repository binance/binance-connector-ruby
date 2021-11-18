#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key and secret here
# or BINANCE_PUBLIC_API_KEY and BINANCE_PRIVATE_SECRET in env
client = Binance::Spot.new(key: '')
logger.info(client.mining_resale_request(
              userName: '',
              algo: '',
              startDate: '',
              endDate: '',
              toPoolUser: '',
              hashRate: ''
            ))
