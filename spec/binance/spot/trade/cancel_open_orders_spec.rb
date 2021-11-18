# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#cancel_open_orders' do
  let(:path) { '/api/v3/openOrders' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1589425967140' }
  let(:params) { { symbol: 'BNBUSDT' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:delete, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.cancel_open_orders(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should delete open orders ' do
    spot_client_signed.cancel_open_orders(**params)
    expect(send_a_request_with_signature(:delete, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        recvWindow: 10_000,
        symbol: 'BNBUSDT'
      }
    end

    it 'should delete open orders' do
      spot_client_signed.cancel_open_orders(**params)
      expect(send_a_request_with_signature(:delete, path, params)).to have_been_made
    end
  end
end
