#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(base_url: 'https://testnet.binance.vision')
logger.info(client.trades(symbol: 'BTCUSDT'))

# with limit
logger.info(client.trades(symbol: 'BTCUSDT', limit: 5))
