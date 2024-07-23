# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#exchangeInfo' do
  let(:path) { '/api/v3/exchangeInfo' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  it 'should return exchangeInfo' do
    spot_client.exchange_info
    expect(send_a_request(:get, path)).to have_been_made
  end

  context 'with param symbol' do
    let(:symbol) { 'BTCUSDT' }
    let(:path) { "/api/v3/exchangeInfo?symbol=#{symbol}" }
    it 'should return specific symbol exchange Info' do
      spot_client.exchange_info(symbol: symbol)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end

  context 'with param symbols' do
    context 'one symbol' do
      let(:symbols) { ['BTCUSDT'] }
      let(:path) { '/api/v3/exchangeInfo?symbols=%5B%22BTCUSDT%22%5D' }
      it 'should return specific symbol exchange Info' do
        spot_client.exchange_info(symbols: symbols)
        expect(send_a_request(:get, path)).to have_been_made
      end
    end

    context 'two symbol' do
      let(:symbols) { %w[BNBBTC BTCUSDT] }
      let(:path) { '/api/v3/exchangeInfo?symbols=%5B%22BNBBTC%22,%22BTCUSDT%22%5D' }
      it 'should return specific symbol exchange Info' do
        spot_client.exchange_info(symbols: symbols)
        expect(send_a_request(:get, path)).to have_been_made
      end
    end
  end

  context 'with param permissions' do
    context 'one permission' do
      let(:permissions) { 'SPOT' }
      let(:path) { '/api/v3/exchangeInfo?permissions=SPOT' }
      it 'should return specific permission exchange Info' do
        spot_client.exchange_info(permissions: permissions)
        expect(send_a_request(:get, path)).to have_been_made
      end
    end

    context 'two permission' do
      let(:permissions) { %w[MARGIN LEVERAGED] }
      let(:path) { '/api/v3/exchangeInfo?permissions=%5B%22MARGIN%22,%22LEVERAGED%22%5D' }
      it 'should return specific permission exchange Info' do
        spot_client.exchange_info(permissions: permissions)
        expect(send_a_request(:get, path)).to have_been_made
      end
    end
  end
end
