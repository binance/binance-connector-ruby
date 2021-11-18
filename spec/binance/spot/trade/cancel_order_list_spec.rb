# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#cancel_order_list' do
  let(:path) { '/api/v3/orderList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { symbol: 'BNBUSDT' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:delete, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.cancel_order_list(symbol: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should delete a oco order ' do
    spot_client_signed.cancel_order_list(**params)
    expect(send_a_request_with_signature(:delete, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        symbol: 'BNBUSDT',
        orderListId: 1111,
        listClientOrderId: '2222',
        newClientOrderId: '3333',
        recvWindow: 10_000
      }
    end

    it 'should delete a oco order' do
      spot_client_signed.cancel_order_list(**params)
      expect(send_a_request_with_signature(:delete, path, params)).to have_been_made
    end
  end
end
