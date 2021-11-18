#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# set key here
# or BINANCE_PUBLIC_API_KEY in env

key = ''
client = Binance::Spot.new(key: key)

logger.info(client.renew_listen_key(''))
