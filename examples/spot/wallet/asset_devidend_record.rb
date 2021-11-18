#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
param = {
  "asset": 'BNB'
}
logger.info(client.asset_devidend_record(param))
