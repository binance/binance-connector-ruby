#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
logger.info(client.sub_account_toggle_ip_restriction(email: 'alice@test.com', subAccountApiKey: 'xxxxxx', status: '1'))
