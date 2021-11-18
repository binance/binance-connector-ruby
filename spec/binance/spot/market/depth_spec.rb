# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#depth' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/depth?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.depth(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return orderbook without given limit' do
    spot_client.depth(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end

  describe 'with params' do
    let(:limit) { 10 }
    let(:path) { "/api/v3/depth?symbol=#{symbol}&limit=#{limit}" }
    it 'should return orderbook with given limit' do
      spot_client.depth(symbol: symbol, limit: limit)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
