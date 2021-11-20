# frozen_string_literal: true

require 'bundler/setup'

require 'webmock/rspec'
require 'addressable/template'
require 'rspec-parameterized'
require 'simplecov'

require 'binance'

BASE_URL = 'https://api.binance.com'

FAKE_SECRET = 'secret'
FAKE_SIGNATURE = '07ac61c8cfbeaf3d86f1e4e96f97fc2c56227e243ed490b0dc9401a422ea6014'

SimpleCov.start do
  enable_coverage :branch
end

def now
  DateTime.new(2009, 1, 3, 1, 1, 1)
end

def timestamp
  now.strftime('%Q')
end

def spot_client
  Binance::Spot.new
end

def spot_client_signed
  Binance::Spot.new(key: '', secret: FAKE_SECRET)
end

def stub_binance_request(verb, path, status, body)
  stub_send_binance_request(verb, path).to_return(
    body: body.to_json,
    status: status,
    headers: {
      'Content-Type' => 'application/json',
      'User-Agent' => "binance-connector-ruby/#{Binance::VERSION}"
    }
  )
end

def stub_binance_sign_request(verb, path, status, body, params = {})
  stub_encoder(params)
  query_string = build_query(
    params.merge(
      "signature": FAKE_SIGNATURE
    )
  )
  stub_send_binance_request(verb, "#{path}?#{query_string}").to_return(
    body: body.to_json,
    status: status,
    headers: {
      'Content-Type' => 'application/json',
      'User-Agent' => "binance-connector-ruby/#{Binance::VERSION}",
      'X-Mbx-Apikey' => ''
    }
  )
end

def stub_send_binance_request(verb, path)
  stub_request(verb, "https://api.binance.com#{path}")
end

def mocking_signature_and_ts(params = {})
  allow(OpenSSL::Digest).to receive(:new).and_return('')
  allow(OpenSSL::HMAC).to receive(:hexdigest).with('', FAKE_SECRET, build_query(**params)).and_return(FAKE_SIGNATURE)
  mock_time
end

def stub_encoder(params)
  allow(Binance::Utils::Faraday::CustomParamsEncoder).to receive(:encode) do
    sorted_encode(params)
  end
end

def sorted_encode(params)
  if params.nil?
    nil
  elsif params.is_a?(Array)
    Binance::Utils::Faraday::CustomParamsEncoder.encode_array params
  elsif params.respond_to?(:to_hash)
    params = params.to_hash.map do |key, value|
      key = key.to_s if key.is_a?(Symbol)
      [key, value]
    end
    params.sort!
    Binance::Utils::Faraday::CustomParamsEncoder.encode_array params
  else
    raise TypeError, "Can't encode #{params.class}."
  end
end

def build_query(params = {})
  Binance::Utils::Url.build_query(params.sort.to_h.merge("timestamp": timestamp))
end

def mock_time
  allow(DateTime).to receive(:now).and_return(now)
end

def fixture_path
  File.expand_path('fixtures', __dir__)
end

def fixture(file)
  File.new(File.join(fixture_path, '/', file))
end

def send_a_request(verb, path)
  a_request(verb, "#{BASE_URL}#{path}")
end

def send_a_request_with_signature(verb, path, params = {})
  query_string = build_query(
    params.merge(
      "signature": FAKE_SIGNATURE
    )
  )
  a_request(verb, "#{BASE_URL}#{path}?#{query_string}")
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end
end

RSpec::Expectations.configuration.on_potential_false_positives = :nothing
