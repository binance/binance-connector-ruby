#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# historical trades endpoint require api key, no signature required
# set key and secret here
# or BINANCE_PUBLIC_API_KEY and BINANCE_PRIVATE_SECRET in env
client = Binance::Spot.new(key: '', base_url: 'https://testnet.binance.vision')
logger.info(client.historical_trades(symbol: 'BTCUSDT'))

# with limit
logger.info(client.historical_trades(symbol: 'BTCUSDT', limit: 100))
