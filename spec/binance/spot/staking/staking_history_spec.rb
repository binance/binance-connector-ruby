# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Staking, '#staking_history' do
  let(:path) { '/sapi/v1/staking/stakingRecord' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      product: 'STAKING',
      txnType: 'SUBSCRIPTION'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without parameter product' do
      expect { spot_client_signed.staking_history(product: '', txnType: 'REDEMPTION') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without parameter txnType' do
      expect { spot_client_signed.staking_history(product: 'STAKING', txnType: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with product' do
    it 'should return staking records' do
      spot_client_signed.staking_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
