# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#get_user_asset' do
  let(:path) { '/sapi/v3/asset/getUserAsset' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'with parameters' do
    let(:params) do
      {
        asset: 'BNB',
        needBtcValuation: true
      }
    end
    it 'should return user\'s asset list ' do
      spot_client_signed.get_user_asset(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
