# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#trade_fee' do
  let(:path) { '/sapi/v1/asset/tradeFee' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return trade fee' do
    spot_client_signed.trade_fee
    expect(send_a_request_with_signature(:get, path)).to have_been_made
  end

  context 'with params' do
    let(:params) { { recvWindow: 10_000 } }

    it 'should return trade fee' do
      spot_client_signed.trade_fee(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
