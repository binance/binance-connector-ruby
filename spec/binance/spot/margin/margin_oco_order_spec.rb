# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_oco_order' do
  let(:path) { '/sapi/v1/margin/order/oco' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { symbol: '', side: 'BUY', quantity: 1, price: 400.5, stopPrice: 400 },
        { symbol: 'BNBUSDT', side: '', quantity: 1, price: 400.5, stopPrice: 400 },
        { symbol: 'BNBUSDT', side: 'BUY', quantity: '', price: 400.5, stopPrice: 400 },
        { symbol: 'BNBUSDT', side: 'BUY', quantity: 1, price: '', stopPrice: 400 },
        { symbol: 'BNBUSDT', side: 'BUY', quantity: 1, price: 400.5, stopPrice: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.margin_oco_order(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with complete parameter' do
    let(:params) { { symbol: 'BNBUSDT', side: 'BUY', quantity: 1, price: 410, stopPrice: 400, stopLimitPrice: 400.5, stopLimitTimeInForce: 'GTC' } }
    it 'should return all oco' do
      spot_client_signed.margin_oco_order(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
