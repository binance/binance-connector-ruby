#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', base_url: 'https://testnet.binance.vision')
logger.info(client.reference_price_calculation(symbol: 'BTCUSDT'))
