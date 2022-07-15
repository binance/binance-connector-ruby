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
  type: 'LIMIT',
  cancelReplaceMode: 'STOP_ON_FAILURE',
  timeInForce: 'GTC',
  quantity: 1,
  price: 200,
  cancelOrderId: 1_234_567, # this should be a real existing open order id.
  newOrderRespType: 'FULL'
}

logger.info(client.cancel_replace(**params))
