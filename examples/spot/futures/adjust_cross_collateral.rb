#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env
client = Binance::Spot.new(key: '', secret: '')

logger.info(client.adjust_cross_collateral(loanCoin: 'BUSD', collateralCoin: 'BTC', amount: 1, direction: 'ADDITIONAL'))
