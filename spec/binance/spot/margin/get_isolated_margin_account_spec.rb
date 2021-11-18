# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#get_isolated_margin_account' do
  let(:path) { '/sapi/v1/margin/isolated/account' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'without parameter' do
    it 'should return isolated margin account status' do
      spot_client_signed.get_isolated_margin_account
      expect(send_a_request_with_signature(:get, path)).to have_been_made
    end
  end

  context 'with recvWindow' do
    let(:params) do
      {
        "symbols": 'BNBUSDT',
        "recvWindow": 5000
      }
    end
    it 'should return isolated margin account status' do
      spot_client_signed.get_isolated_margin_account(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end

  context 'with multiple symbols' do
    let(:params) do
      {
        "symbols": %w[BNBBTC BTCUSDT]
      }
    end
    it 'should return isolated margin account status' do
      spot_client_signed.get_isolated_margin_account(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
