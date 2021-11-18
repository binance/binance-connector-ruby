# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_get_oco' do
  let(:path) { '/sapi/v1/margin/orderList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'without parameter' do
    let(:params) { {} }
    it 'should return oco' do
      spot_client_signed.margin_get_oco
      expect(send_a_request_with_signature(:get, path)).to have_been_made
    end
  end

  context 'with symbol' do
    let(:params) { { "symbol": 'BNBUSDT' } }
    it 'should return oco' do
      spot_client_signed.margin_get_oco(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
