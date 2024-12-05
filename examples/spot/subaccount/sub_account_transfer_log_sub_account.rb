#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
logger.info(client.sub_account_transfer_log_sub_account(startTime: 1_640_998_861_000, endTime: 1_646_096_461_000, page: 1, limit: 10))
