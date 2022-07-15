#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new

# single symbol
# logger.info(client.ticker(symbol: 'btcusdt', windowSize: '1d'))

# multi symbols
logger.info(client.ticker(symbols: %w[btcusdt btcbusd], windowSize: '1d'))
