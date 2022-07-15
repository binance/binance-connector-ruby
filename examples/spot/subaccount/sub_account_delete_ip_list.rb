#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
logger.info(client.sub_account_delete_ip_list(email: 'alice@test.com', subAccountApiKey: 'xxxxxx', ipAddress: '1.2.3.4'))
