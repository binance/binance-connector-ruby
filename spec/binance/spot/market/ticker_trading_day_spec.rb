# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#ticker_trading_day' do
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    let(:path) { '/api/v3/ticker/tradingDay' }

    it 'should raise duplicated parameters error with both symbol and symbols' do
      expect { spot_client.ticker_trading_day(symbol: 'BNBUSDT', symbols: ['BTCUSDT']) }.to raise_error(Binance::DuplicatedParametersError)
    end
  end

  context 'with symbol' do
    let(:path) { '/api/v3/ticker/tradingDay?symbol=BNBUSDT' }

    it 'should return price change statistics for a trading day' do
      spot_client.ticker_trading_day(symbol: 'BNBUSDT')
      expect(send_a_request(:get, path)).to have_been_made
    end
  end

  context 'with symbols' do
    let(:path) { '/api/v3/ticker/tradingDay?symbols=["BTCUSDT","BNBUSDT"]&timeZone=8' }

    it 'should return price change statistics for a trading day' do
      spot_client.ticker_trading_day(symbols: %w[btcusdt bnbusdt], timeZone: 8)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
