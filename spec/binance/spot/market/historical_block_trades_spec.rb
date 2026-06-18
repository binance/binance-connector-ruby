# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#historicalBlockTrades' do
  let(:symbol) { 'BNBUSDT' }
  let(:limit) { 5 }
  let(:path) { "/api/v3/historicalBlockTrades?symbol=#{symbol}&limit=#{limit}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.historical_block_trades(symbol: '', limit: limit) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return historical block trades' do
    spot_client.historical_block_trades(symbol: symbol, limit: limit)
    expect(send_a_request(:get, path)).to have_been_made
  end
end
