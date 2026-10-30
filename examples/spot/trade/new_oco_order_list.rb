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
  side: 'SELL',
  quantity: 1,
  aboveType: 'LIMIT_MAKER',
  abovePrice: 610,
  belowType: 'STOP_LOSS_LIMIT',
  belowStopPrice: 590,
  belowPrice: 589,
  belowTimeInForce: 'GTC'
}

logger.info(client.new_oco_order_list(**params))
