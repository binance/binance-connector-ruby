# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_flexible_user_redemption_quota' do
  let(:path) { '/sapi/v1/lending/daily/userRedemptionQuota' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      productId: 'product_id',
      type: 'FAST'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without productId' do
      expect { spot_client_signed.savings_flexible_user_redemption_quota(productId: '', type: 'FAST') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without type' do
      expect { spot_client_signed.savings_flexible_user_redemption_quota(productId: '123456', type: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return left daily redemption qutoa' do
    spot_client_signed.savings_flexible_user_redemption_quota(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
