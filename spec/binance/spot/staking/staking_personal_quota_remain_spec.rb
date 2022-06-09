# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Staking, '#staking_personal_quota_remain' do
  let(:path) { '/sapi/v1/staking/personalLeftQuota' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      product: 'STAKING',
      productId: 'Matic*9'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without parameter product' do
      expect { spot_client_signed.staking_personal_quota_remain(product: '', productId: 'Matic*9') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without parameter productId' do
      expect { spot_client_signed.staking_personal_quota_remain(product: 'STAKING', productId: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return staking personal remaining quota' do
    spot_client_signed.staking_personal_quota_remain(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
