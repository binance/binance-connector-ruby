# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#new_order' do
  let(:path) { '/api/v3/order' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      price: '1000',
      side: 'BUY',
      symbol: 'BNBUSDT',
      timeInForce: 'GTC',
      type: 'LIMIT'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { symbol: '', side: 'BUY', type: 'LIMIT' } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.new_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation side' do
    let(:params) { { symbol: 'BNBUSDT', side: '', type: 'LIMIT' } }
    it 'should raise validation error without side' do
      expect { spot_client_signed.new_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation type' do
    let(:params) { { symbol: 'BNBUSDT', side: 'BUY', type: '' } }
    it 'should raise validation error without type' do
      expect { spot_client_signed.new_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should create a new order ' do
    spot_client_signed.new_order(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end

  context 'with parameters' do
    # it should add parameters together to place an order, but we are testing if the parameters can be add to url
    let(:params) do
      {
        symbol: 'BNBUSDT',
        price: '1000',
        side: 'BUY',
        type: 'LIMIT',
        quantity: 1,
        timeInForce: 'GTC',
        icebergQty: 1.5,
        newClientOrderId: 'my_order_1',
        newOrderRespType: 'RESULT',
        stopPrice: 21,
        recvWindow: 2_000
      }
    end
    it 'should create a new order' do
      spot_client_signed.new_order(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
