# frozen_string_literal: true

require 'faraday'
require 'binance/utils/faraday/middleware'
require 'binance/utils/faraday/custom_params_encoder'

module Binance
  # Session has the http request connection
  class Session
    include Binance::Utils::Faraday::Middleware

    def initialize(options = {})
      @base_url = options[:base_url] || 'https://api.binance.com'
      @proxy_url = options[:proxy_url]
      @auth = Authentication.new(options[:key], options[:secret], options[:private_key], options[:private_key_pass_phrase])
      @logger = options[:logger]
      @show_weight_usage = options[:show_weight_usage] || false
      @show_header = options[:show_header] || false
      @timeout = options[:timeout]
    end

    def public_request(path: '/', params: {})
      process_request(public_conn, :get, path, params)
    end

    def limit_request(method: :get, path: '/', params: {})
      process_request(limit_conn, method, path, params)
    end

    def sign_request(method, path, params: {})
      process_request(signed_conn, method, path, params)
    end

    private

    def process_request(conn, method, path, params)
      response = conn.send(method, path_with_query(path, params.compact), nil)
      extract_response(response)
    rescue Faraday::ClientError => e
      raise Binance::ClientError, e.response
    rescue Faraday::ServerError => e
      raise Binance::ServerError, e
    end

    def extract_response(response)
      begin
        data = JSON.parse(response.body, symbolize_names: true)
      rescue JSON::ParserError
        data = response.body
      end

      return data if !@show_header && !@show_weight_usage

      res = { data: data }
      res[:header] = response.headers if @show_header
      res[:weight_usage] = response.headers.select { |k, _| weight_usage?(k) } if @show_weight_usage
      res
    end

    def weight_usage?(key)
      key.start_with?('x-mbx-used-weight') || key.start_with?('x-sapi-used')
    end

    def path_with_query(path, params)
      "#{path}?#{Binance::Utils::Url.build_query(params)}"
    end

    def public_conn
      build_connection
    end

    def limit_conn
      build_connection do |conn|
        conn.headers['X-MBX-APIKEY'] = @auth.key
      end
    end

    def signed_conn
      build_connection do |conn|
        conn.headers['X-MBX-APIKEY'] = @auth.key
        conn.use Timestamp
        conn.use RSASignature, @auth if @auth.provide_private_key?
        conn.use HMACSignature, @auth unless @auth.provide_private_key?
      end
    end

    def build_connection
      params = { url: @base_url }
      params.merge!(proxy: @proxy_url) if @proxy_url
      Faraday.new(params) do |client|
        prepare_headers(client)
        client.options.timeout = @timeout
        client.options.params_encoder = Binance::Utils::Faraday::CustomParamsEncoder
        yield client if block_given?
        client.use Faraday::Response::RaiseError
        logger_response(client)
        client.adapter Faraday.default_adapter
      end
    end

    def logger_response(client)
      client.response :logger, @logger if @logger
    end

    def prepare_headers(client)
      client.headers['Content-Type'] = 'application/json'
      client.headers['User-Agent'] = "binance-connector-ruby/#{Binance::VERSION}"
    end
  end
end
