#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

key = ''
secret = ''

client = Binance::Spot.new(key: key, secret: secret)
logger.info(client.repay_flexible_loan(loanCoin: 'BUSD', collateralCoin: 'BNB', repayAmount: 1.0))
