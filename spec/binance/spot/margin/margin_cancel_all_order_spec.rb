# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_cancel_all_order' do
  let(:path) { '/sapi/v1/margin/openOrders' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:delete, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { "symbol": '' } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.margin_cancel_all_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with symbol' do
    let(:params) { { "symbol": 'BNBUSDT' } }
    it 'should return all oco' do
      spot_client_signed.margin_cancel_all_order(**params)
      expect(send_a_request_with_signature(:delete, path, params)).to have_been_made
    end
  end
end
