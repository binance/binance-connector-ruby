#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

key = ''
secret = ''

client = Binance::Spot.new(key: key, secret: secret)
logger.info(client.adjust_flexible_loan_ltv(loanCoin: 'BUSD', collateralCoin: 'BNB', adjustmentAmount: 1.0, direction: 'ADDITIONAL'))
