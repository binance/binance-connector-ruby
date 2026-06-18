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
  workingType: 'LIMIT',
  workingSide: 'BUY',
  workingPrice: 1.0,
  workingQuantity: 1.0,
  workingTimeInForce: 'GTC',
  pendingType: 'LIMIT',
  pendingSide: 'SELL',
  pendingTimeInForce: 'GTC',
  pendingPrice: 1.0
}

logger.info(client.new_opo_order_list(params))
