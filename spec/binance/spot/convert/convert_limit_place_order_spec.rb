# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Convert, '#convert_limit_place_order' do
  let(:path) { '/sapi/v1/convert/limit/placeOrder' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { baseAsset: '', quoteAsset: 'USDT', limitPrice: 590.0, side: 'BUY', expiredType: '1_D', baseAmount: 1.0 },
        { baseAsset: 'BNB', quoteAsset: '', limitPrice: 590.0, side: 'BUY', expiredType: '1_D', baseAmount: 1.0 },
        { baseAsset: 'BNB', quoteAsset: 'USDT', limitPrice: '', side: 'BUY', expiredType: '1_D', baseAmount: 1.0 },
        { baseAsset: 'BNB', quoteAsset: 'USDT', limitPrice: 590.0, side: '', expiredType: '1_D', baseAmount: 1.0 },
        { baseAsset: 'BNB', quoteAsset: 'USDT', limitPrice: 590.0, side: 'BUY', expiredType: '', baseAmount: 1.0 }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.convert_limit_place_order(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with params' do
    let(:params) { { baseAsset: 'BNB', quoteAsset: 'USDT', limitPrice: 590.0, side: 'BUY', expiredType: '1_D', baseAmount: 1.0 } }
    it 'should place a limit order' do
      spot_client_signed.convert_limit_place_order(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
