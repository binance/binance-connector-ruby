#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env
client = Binance::Spot.new(key: '')
params = {
  symbol: 'BNBUSDT',
  side: 'SELL',
  type: 'LIMIT',
  quantity: 1,
  price: '30',
  timeInForce: 'GTC',
  recvWindow: 5_000
}
logger.info(client.margin_new_order(**params))
