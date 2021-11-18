# frozen_string_literal: true

require 'date'

module Binance
  module Utils
    module Faraday
      # Custom parameter encoder
      module CustomParamsEncoder
        class << self
          extend Forwardable
          def_delegators :'Faraday::Utils', :escape, :unescape
        end

        def self.encode(params)
          if params.nil?
            nil
          elsif params.is_a?(Array)
            # The params have form [['key1', 'value1'], ['key2', 'value2']].
            encode_array params
          elsif params.respond_to?(:to_hash)
            params = params.to_hash.map do |key, value|
              key = key.to_s if key.is_a?(Symbol)
              [key, value]
            end
            encode_array params
          else
            raise TypeError, "Can't encode #{params.class}."
          end
        end

        def self.encode_array(params)
          buffer = ''.dup
          params.each do |key, value|
            encoded_key = escape(key)
            if Binance::Utils::Validation.invalid?(value)
              buffer << "#{encoded_key}&"
            elsif value.is_a?(Array)
              value.each do |sub_value|
                buffer << "#{encoded_key}=#{escape sub_value}&"
              end
            else
              value = value.to_s if [true, false].include?(value)
              buffer << "#{encoded_key}=#{value}&"
            end
          end
          buffer.chomp '&'
        end

        # rubocop:disable Metrics/AbcSize
        def self.decode(query)
          return nil if query.nil?

          param_pairs = split_query query
          param_pairs.each_with_object({}) do |pair, accu|
            key = unescape(pair[0])
            value = pair[1] || true
            value = unescape(value.to_str.gsub(/\+/, ' ')) if value.respond_to?(:to_str)
            if accu[key].is_a?(Array)
              accu[key] << value
            elsif accu[key] # already a value for this key
              accu[key] = [accu[key], value]
            else
              accu[key] = value
            end
          end
        end
        # rubocop:enable Metrics/AbcSize

        def self.split_query(query)
          (query.split('&').map do |pair|
            pair.split('=', 2) if pair && !pair.empty?
          end).compact
        end
      end
    end
  end
end
