#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
params = {
  "email": 'alice@test.com',
  "asset": 'BNB',
  "amount": 1,
  "type": 1
}
logger.info(client.sub_account_margin_transfer(**params))
