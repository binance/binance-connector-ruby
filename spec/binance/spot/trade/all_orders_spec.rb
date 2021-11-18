# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#all_orders' do
  let(:path) { '/api/v3/allOrders' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1589425967140' }
  let(:params) { { symbol: 'BNBUSDT' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.all_orders(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return all orders ' do
    spot_client_signed.all_orders(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        endTime: ts,
        fromId: '111',
        recvWindow: 10_000,
        startTime: ts,
        symbol: 'BNBUSDT'
      }
    end

    it 'should return my trades' do
      spot_client_signed.all_orders(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
