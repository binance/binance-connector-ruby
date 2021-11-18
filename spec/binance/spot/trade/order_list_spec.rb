# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#order_list' do
  let(:path) { '/api/v3/orderList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1589425967140' }
  let(:params) { { orderListId: '11111' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return a oco order ' do
    spot_client_signed.order_list(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        orderListId: '1111',
        origClientOrderId: '111',
        recvWindow: 10_000
      }
    end

    it 'should return an oco order' do
      spot_client_signed.order_list(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
