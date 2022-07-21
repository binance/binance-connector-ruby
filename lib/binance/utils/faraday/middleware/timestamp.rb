# frozen_string_literal: true

module Binance
  module Utils
    module Faraday
      module Middleware
        Timestamp = Struct.new(:app, :timestamp) do
          def call(env)
            env.url.query = Url.add_param(
              env.url.query, 'timestamp', timestamp
            )
            app.call env
          end
        end
      end
    end
  end
end
