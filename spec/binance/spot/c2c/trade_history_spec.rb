# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::C2C, '#c2c_trade_history' do
  let(:path) { '/sapi/v1/c2c/orderMatch/listUserOrderHistory' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { tradeType: 'BUY' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without tradeType' do
      expect { spot_client_signed.c2c_trade_history(tradeType: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return trade history ' do
    spot_client_signed.c2c_trade_history(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end

  context 'with params' do
    let(:params) do
      {
        tradeType: 'BUY',
        page: 1,
        row: 2,
        recvWindow: 10_000
      }
    end

    it 'should return my trades' do
      spot_client_signed.c2c_trade_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
