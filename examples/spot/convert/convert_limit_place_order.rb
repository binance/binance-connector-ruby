#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env
client = Binance::Spot.new(key: '', secret: '')

logger.info(client.convert_limit_place_order(baseAsset: 'BNB', quoteAsset: 'USDT', limitPrice: 590.0, side: 'BUY', expiredType: '1_D', baseAmount: 1.0))
