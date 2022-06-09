# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Blvt, '#user_limit' do
  let(:tokenName) { 'BTCDOWN' }
  let(:path) { '/sapi/v1/blvt/userLimit' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      tokenName: 'BTCDOWN'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    it 'should get redeem limit' do
      spot_client_signed.user_limit(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
