# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#ticker' do
  let(:symbol) { 'BNBUSDT' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'with both symbol and symbols' do
    let(:path) { '/api/v3/ticker' }
    it 'should raise error' do
      expect do
        spot_client.ticker(symbol: symbol, symbols: %w[BNBBUSD BNBUSDT])
      end.to raise_error(Binance::DuplicatedParametersError)
    end
  end

  context 'with symbol' do
    let(:path) { "/api/v3/ticker?symbol=#{symbol}&windowSize=1d" }
    it 'should return one ticker' do
      spot_client.ticker(symbol: symbol)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end

  context 'with symbols' do
    let(:path) { '/api/v3/ticker?symbols=["BNBBUSD","BNBUSDT"]&windowSize=1h' }
    it 'should return 2 symbols\' ticker' do
      spot_client.ticker(symbols: %w[BNBBUSD BNBUSDT], windowSize: '1h')
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
