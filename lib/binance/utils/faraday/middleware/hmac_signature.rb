# frozen_string_literal: true

require 'openssl'
require 'base64'

module Binance
  module Utils
    module Faraday
      module Middleware
        HMACSignature = Struct.new(:app, :auth) do
          def call(env)
            env.url.query = Url.add_param(env.url.query, 'signature', auth.hmac_sign(env.url.query))
            app.call env
          end
        end
      end
    end
  end
end
