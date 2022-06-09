# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_open_orders' do
  let(:path) { '/sapi/v1/margin/openOrders' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    let(:params) do
      {
        symbol: 'BNB',
        recvWindow: 1_000
      }
    end
    it 'should query margin open orders' do
      spot_client_signed.margin_open_orders(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
