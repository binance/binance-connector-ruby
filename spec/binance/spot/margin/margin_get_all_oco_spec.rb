# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_get_all_oco' do
  let(:path) { '/sapi/v1/margin/allOrderList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'without params' do
    let(:params) { {} }
    it 'should return all oco' do
      spot_client_signed.margin_get_all_oco(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end

  context 'with symbol' do
    let(:params) { { symbol: 'BNBUSDT' } }
    it 'should return all oco' do
      spot_client_signed.margin_get_all_oco(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
