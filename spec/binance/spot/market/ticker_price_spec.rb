# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#ticker_price' do
  let(:symbol) { 'BNBUSDT' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'with symbol' do
    let(:path) { "/api/v3/ticker/price?symbol=#{symbol}" }
    it 'should return one ticker price' do
      spot_client.ticker_price(symbol: symbol)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end

  context 'without symbol' do
    let(:path) { '/api/v3/ticker/price' }
    it 'should return all symbols ticker price' do
      spot_client.ticker_price
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
