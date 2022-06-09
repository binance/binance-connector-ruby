# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Staking, '#staking_redeem' do
  let(:path) { '/sapi/v1/staking/redeem' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      product: 'STAKING',
      productId: 'Matic*90',
      amount: 1
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without parameter product' do
      expect { spot_client_signed.staking_redeem(product: '', productId: 'Matic*90') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without parameter productId' do
      expect { spot_client_signed.staking_redeem(product: 'STAKING', productId: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with product' do
    it 'should send rquest to redeem stake product' do
      spot_client_signed.staking_redeem(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
