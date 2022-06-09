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
  price: '20',
  side: 'BUY',
  symbol: 'BNBUSDT',
  timeInForce: 'GTC',
  type: 'LIMIT',
  quantity: 1,
  newClientOrderId: 'my_order_1',
  newOrderRespType: 'RESULT',
  recvWindow: 2_000
}

# if the request is not valid, will return error
logger.info(client.new_order_test(**params))
