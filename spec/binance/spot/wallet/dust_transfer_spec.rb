# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#dust_transfer' do
  let(:path) { '/sapi/v1/asset/dust ' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      asset: %w[EOS ETH]
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without asset' do
      expect { spot_client_signed.dust_transfer(asset: '') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without asset' do
      expect { spot_client_signed.dust_transfer(asset: []) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return account status' do
    spot_client_signed.dust_transfer(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
