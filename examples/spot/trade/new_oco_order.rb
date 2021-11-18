#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key and secret here
# or BINANCE_PUBLIC_API_KEY and BINANCE_PRIVATE_SECRET in env

key = ''
secret = ''
client = Binance::Spot.new(key: key, secret: secret, base_url: 'https://testnet.binance.vision')

params = {
  symbol: 'BNBUSDT',
  side: 'BUY',
  quantity: 0.1,
  price: 370,
  stopPrice: 375,
  stopLimitPrice: 374.8,
  stopLimitTimeInForce: 'GTC'
}

logger.info(client.new_oco_order(params))
