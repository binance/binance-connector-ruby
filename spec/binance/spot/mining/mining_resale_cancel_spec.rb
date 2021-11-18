# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_resale_cancel' do
  let(:path) { '/sapi/v1/mining/hash-transfer/config/cancel' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:userName) { 'mining_acct' }
  let(:configId) { 168 }
  let(:params) do
    {
      "userName": userName,
      "configId": configId
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without userName' do
      expect do
        spot_client_signed.mining_resale_cancel(
          userName: '',
          configId: configId
        )
      end.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without algo' do
      expect do
        spot_client_signed.mining_resale_cancel(
          userName: userName,
          configId: ''
        )
      end.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return request hashrate resale' do
    spot_client_signed.mining_resale_cancel(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
