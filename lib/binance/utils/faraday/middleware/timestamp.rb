# frozen_string_literal: true

require 'date'

module Binance
  module Utils
    module Faraday
      module Middleware
        Timestamp = Struct.new(:app) do
          def call(env)
            env.url.query = Url.add_param(
              env.url.query, 'timestamp', DateTime.now.strftime('%Q')
            )
            app.call env
          end
        end
      end
    end
  end
end
