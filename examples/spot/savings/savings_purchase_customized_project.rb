#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key and secret here
# or BINANCE_PUBLIC_API_KEY and BINANCE_PRIVATE_SECRET in env

key = ''
secret = ''
client = Binance::Spot.new(key: key, secret: secret)

logger.info(client.savings_purchase_customized_project(projectId: '111', lot: 1))
