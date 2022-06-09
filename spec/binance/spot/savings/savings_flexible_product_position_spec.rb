# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_flexible_product_position' do
  let(:path) { '/sapi/v1/lending/daily/token/position' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      asset: 'BNB'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without asset' do
      expect { spot_client_signed.savings_flexible_product_position(asset: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return product position' do
    spot_client_signed.savings_flexible_product_position(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
