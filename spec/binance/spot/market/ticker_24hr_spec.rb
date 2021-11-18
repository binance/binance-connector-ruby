# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#ticker_24hr' do
  let(:symbol) { 'BNBUSDT' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'with symbol' do
    let(:path) { "/api/v3/ticker/24hr?symbol=#{symbol}" }
    it 'should return one symbol 24hr ticker' do
      spot_client.ticker_24hr(symbol: symbol)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end

  context 'without symbol' do
    let(:path) { '/api/v3/ticker/24hr' }
    it 'should return all pairs 24hr ticker' do
      spot_client.ticker_24hr
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
