#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require 'eventmachine'
require_relative '../../common'

logger = Common.setup_logger

# on spot testnet
client = Binance::Spot::WebSocket.new(base_url: 'wss://stream.testnet.binance.vision')

EM.run do
  onopen = proc { logger.info('connected to server') }
  onmessage = proc { |msg, _type| logger.info(msg) }
  onerror   = proc { |e| logger.error(e) }
  onclose   = proc { logger.info('connection closed') }

  callbacks = {
    onopen: onopen,
    onmessage: onmessage,
    onerror: onerror,
    onclose: onclose
  }

  # with listen key
  client.user_data(stream: '<listen_key>', callbacks: callbacks)
end
