# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Mining, '#mining_resale_detail' do
  let(:path) { '/sapi/v1/mining/hash-transfer/profit/details' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:configId) { 168 }
  let(:userName) { 'mining_acct' }
  let(:pageIndex) { 1 }
  let(:pageSize) { 100 }
  let(:params) do
    {
      configId: configId,
      userName: userName,
      pageIndex: pageIndex,
      pageSize: pageSize
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without configId' do
      expect { spot_client_signed.mining_resale_detail(configId: '', userName: userName) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without userName' do
      expect { spot_client_signed.mining_resale_detail(configId: configId, userName: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return hashrate resale details' do
    spot_client_signed.mining_resale_detail(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
