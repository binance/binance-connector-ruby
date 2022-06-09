# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Staking, '#staking_product_list' do
  let(:path) { '/sapi/v1/staking/productList' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      product: 'STAKING',
      asset: 'BNB'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without parameter product' do
      expect { spot_client_signed.staking_product_list(product: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return staking product list' do
    spot_client_signed.staking_product_list(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
