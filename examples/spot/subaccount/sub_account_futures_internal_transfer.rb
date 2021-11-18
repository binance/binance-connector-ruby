#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
logger.info(client.sub_account_futures_internal_transfer(fromEmail: '', toEmail: '', futuresType: 1, asset: 'USDT', amount: 0.01))
