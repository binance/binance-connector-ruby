# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#funding_wallet' do
  let(:path) { '/sapi/v1/asset/get-funding-asset' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  it 'should return funding wallet' do
    spot_client_signed.funding_wallet
    expect(send_a_request_with_signature(:post, path)).to have_been_made
  end

  context 'with params' do
    let(:params) { { recvWindow: 10_000 } }

    it 'should return funding wallet' do
      spot_client_signed.funding_wallet(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
