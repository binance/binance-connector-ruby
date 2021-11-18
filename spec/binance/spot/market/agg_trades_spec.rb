# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Market, '#agg_trades' do
  let(:symbol) { 'BNBUSDT' }
  let(:path) { "/api/v3/aggTrades?symbol=#{symbol}" }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    stub_binance_request(:get, path, status, body)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client.agg_trades(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return aggregate trades without given limit' do
    spot_client.agg_trades(symbol: symbol)
    expect(send_a_request(:get, path)).to have_been_made
  end

  describe 'with params' do
    let(:params) do
      { symbol: symbol,
        fromId: 10,
        limit: 500,
        startTime: '1589507863477',
        endTime: '1589507863477' }
    end

    let(:path) { "/api/v3/aggTrades?#{Binance::Utils::Url.build_query(**params)}" }

    it 'should return aggregate trades with given limit' do
      spot_client.agg_trades(**params)
      expect(send_a_request(:get, path)).to have_been_made
    end
  end
end
