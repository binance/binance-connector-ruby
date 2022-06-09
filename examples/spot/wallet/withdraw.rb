#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

client = Binance::Spot.new(key: '', secret: '')
param = {
  coin: 'BNB',
  address: '',
  amount: 0.1,
  withdrawOrderId: 'withdraw_order_id',
  network: 'BNB',
  addressTag: 'myaddress',
  name: 'address_name'
}
logger.info(client.withdraw(param))
