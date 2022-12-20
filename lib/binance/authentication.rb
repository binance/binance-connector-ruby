# frozen_string_literal: true

require 'openssl'
require 'base64'

module Binance
  # Authentication response to API key and signature
  class Authentication
    attr_accessor :key, :secret, :private_key, :private_key_pass_phrase

    def initialize(key, secret, private_key = nil, private_key_pass_phrase = nil)
      @key = key
      @secret = secret
      @private_key = private_key
      @private_key_pass_phrase = private_key_pass_phrase
    end

    def provide_private_key?
      private_key
    end

    def hmac_sign(data)
      OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new('sha256'), secret, data
      )
    end

    def rsa_sign(data)
      pkey = OpenSSL::PKey::RSA.new(private_key, private_key_pass_phrase)
      Base64.encode64(pkey.sign('SHA256', data))
    end
  end
end
