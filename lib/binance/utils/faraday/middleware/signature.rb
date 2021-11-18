# frozen_string_literal: true

require 'openssl'

module Binance
  module Utils
    module Faraday
      module Middleware
        Signature = Struct.new(:app, :secret) do
          def call(env)
            hash = OpenSSL::HMAC.hexdigest(
              OpenSSL::Digest.new('sha256'), secret, env.url.query
            )
            env.url.query = Url.add_param(env.url.query, 'signature', hash)
            app.call env
          end
        end
      end
    end
  end
end
