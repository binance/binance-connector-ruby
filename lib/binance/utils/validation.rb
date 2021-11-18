# frozen_string_literal: true

module Binance
  module Utils
    # Client side validation
    class Validation
      class << self
        def require_param(param_name, param_value)
          raise Binance::RequiredParameterError.new(param_name, param_value) if invalid?(param_value)
        end

        def invalid?(param_value)
          param_value.nil? ||
            (array_or_hash?(param_value) && param_value.empty?) ||
            (param_value.respond_to?(:to_str) && param_value.empty?)
        end

        private

        def array_or_hash?(param_value)
          param_value.is_a?(Array) || param_value.is_a?(Hash)
        end
      end
    end
  end
end
