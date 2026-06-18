# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Trade, '#amend_keep_priority' do
  let(:path) { '/api/v3/order/amendKeepPriority' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:ts) { '1589425967140' }
  let(:params) do
    {
      symbol: 'BNBUSDT',
      orderId: 28_888_888,
      newClientOrderId: 'my_order_0001'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:put, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.amend_keep_priority(**params.merge(symbol: '')) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without orderId' do
      expect { spot_client_signed.amend_keep_priority(**params.merge(orderId: nil)) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without newClientOrderId' do
      expect { spot_client_signed.amend_keep_priority(**params.merge(newClientOrderId: nil)) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should amend order and keep priority' do
    spot_client_signed.amend_keep_priority(**params)
    expect(send_a_request_with_signature(:put, path, params)).to have_been_made
  end
end
