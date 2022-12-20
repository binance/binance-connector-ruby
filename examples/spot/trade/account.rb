#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift('./lib')

require 'binance'
require_relative '../../common'

logger = Common.setup_logger

# HMAC signature; Both API key and secret are required.
key = ''
secret = ''
client = Binance::Spot.new(key: key, secret: secret, base_url: 'https://testnet.binance.vision')
logger.info(client.account(recvWindow: 10_000))

# RSA signature (unencrypted key); API key and RSA private key are required.
key = ''
client = Binance::Spot.new(key: key, private_key: File.read('/path/to/RSA/private/key'), base_url: 'https://testnet.binance.vision')
logger.info(client.account(recvWindow: 10_000))

# RSA signature (encrypted key); API key, RSA private key and the private key pass phrase are required.
key = ''
client = Binance::Spot.new(key: key, private_key: File.read('/path/to/RSA/private/key'), private_key_pass_phrase: 'password', base_url: 'https://testnet.binance.vision')
logger.info(client.account(recvWindow: 10_000))
