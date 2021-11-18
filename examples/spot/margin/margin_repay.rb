#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')

params = {
  "asset": 'BNB',
  "amount": 0.01,
  "recvWindow": 1_000
}

logger.info(client.margin_repay(**params))
