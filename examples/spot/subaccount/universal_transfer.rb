#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
logger.info(client.universal_transfer(fromAccountType: 'SPOT', toAccountType: 'COIN_FUTURE', asset: 'USDT', amount: 0.01))
