# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#book_ticker' do
  let(:symbol) { 'BNBUSDT' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'with symbol' do
    let(:path) { "/api/v3/ticker/bookTicker?symbol=#{symbol}" }
    it 'should return one symbol book ticker' do
      spot_client.book_ticker(symbol: symbol)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end

  context 'without symbol' do
    let(:path) { '/api/v3/ticker/bookTicker' }
    it 'should return all pairs book ticker' do
      spot_client.book_ticker
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
