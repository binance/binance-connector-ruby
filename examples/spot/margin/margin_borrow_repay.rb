#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env
client = Binance::Spot.new(key: '', secret: '')
logger.info(client.margin_borrow_repay(asset: 'BNB', isIsolated: 'TRUE', symbol: 'BNBUSDT', amount: '1.0', type: 'BORROW'))
