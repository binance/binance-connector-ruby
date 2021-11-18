# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#avgPrice' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/avgPrice?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.avg_price(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return avg price' do
    spot_client.avg_price(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end
end
