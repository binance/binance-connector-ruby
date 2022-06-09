# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_new_order' do
  let(:path) { '/sapi/v1/margin/order' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { symbol: '', side: 'BUY', type: 'LIMIT', quantity: 1, recvWindow: 1_000 } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.margin_new_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation side' do
    let(:params) { { symbol: 'BNBUSDT', side: '', type: 'LIMIT', quantity: 1, recvWindow: 1_000 } }
    it 'should raise validation error without side' do
      expect { spot_client_signed.margin_new_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation type' do
    let(:params) { { symbol: 'BNBUSDT', side: 'BUY', type: '', quantity: 1, recvWindow: 1_000 } }
    it 'should raise validation error without type' do
      expect { spot_client_signed.margin_new_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    # it should add parameters together to place an order, but we are testing if the parameters can be add to url
    let(:params) do
      {
        symbol: 'BNBUSDT',
        side: 'BUY',
        type: 'LIMIT',
        quantity: 1,
        recvWindow: 1_000
      }
    end

    it 'should make a new margin order' do
      spot_client_signed.margin_new_order(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
