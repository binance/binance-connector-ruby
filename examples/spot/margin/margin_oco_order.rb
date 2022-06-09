#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env
client = Binance::Spot.new(key: '', secret: '')

params = {
  symbol: 'BNBUSDT',
  side: 'BUY',
  quantity: 0.1,
  price: 410,
  stopPrice: 400,
  stopLimitPrice: 400.1,
  stopLimitTimeInForce: 'GTC'
}

logger.info(client.margin_oco_order(**params))
