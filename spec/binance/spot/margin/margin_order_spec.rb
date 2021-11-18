# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_order' do
  let(:path) { '/sapi/v1/margin/order' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { "symbol": '', "recvWindow": 1_000 } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.margin_order(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        "symbol": 'BNBUSDT',
        "orderId": 'order_id'
      }
    end
    it 'should query margin order' do
      spot_client_signed.margin_order(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
