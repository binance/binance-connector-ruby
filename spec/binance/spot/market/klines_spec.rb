# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#klines' do
  let(:symbol) { 'BNBUSDT' }
  let(:interval) { '1m' }
  let(:path) { "/api/v3/klines?symbol=#{symbol}&interval=#{interval}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.klines(symbol: '', interval: interval) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without interval' do
      expect { spot_client.klines(symbol: symbol, interval: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return klines' do
    spot_client.klines(symbol: symbol, interval: interval)
    expect(send_a_request(:get, path)).to have_been_made
  end

  describe 'with params' do
    let(:params) do
      { symbol: symbol,
        interval: interval,
        startTime: '1589507863477',
        endTime: '1589507863477',
        limit: 500 }
    end
    let(:path) { "/api/v3/klines?#{Binance::Utils::Url.build_query(**params)}" }

    it 'should return orderbook with given limit' do
      spot_client.klines(**params)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
