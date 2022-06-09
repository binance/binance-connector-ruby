# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Staking, '#staking_set_auto' do
  let(:path) { '/sapi/v1/staking/setAutoStaking' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      product: 'STAKING',
      positionId: '123456',
      renewable: 'true'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without parameter product' do
      expect { spot_client_signed.staking_set_auto(product: '', positionId: '123456', renewable: 'true') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without parameter positionId' do
      expect { spot_client_signed.staking_set_auto(product: 'STAKING', positionId: '', renewable: 'true') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without parameter renewable' do
      expect { spot_client_signed.staking_set_auto(product: 'STAKING', positionId: '123456', renewable: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should send rquest to set auto purchase' do
    spot_client_signed.staking_set_auto(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
