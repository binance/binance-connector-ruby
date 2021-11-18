#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env
client = Binance::Spot.new(key: '', secret: '')

logger.info(client.repay_with_collateral(quoteId: '3eece81ca2734042b2f538ea0d9cbdd3'))
