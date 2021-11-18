# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#trades' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/historicalTrades?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.historical_trades(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return historical trades without given limit' do
    spot_client.historical_trades(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end

  describe 'with params' do
    let(:limit) { 10 }
    let(:fromId) { 10 }
    let(:path) { "/api/v3/historicalTrades?symbol=#{symbol}&limit=#{limit}&fromId=#{fromId}" }
    it 'should return trades with given limit' do
      spot_client.historical_trades(symbol: symbol, limit: limit, fromId: fromId)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
