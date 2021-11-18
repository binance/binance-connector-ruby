# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_flexible_user_left_quota' do
  let(:path) { '/sapi/v1/lending/daily/userLeftQuota' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "productId": 'product_id'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without productId' do
      expect { spot_client_signed.savings_flexible_user_left_quota(productId: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return user left quota' do
    spot_client_signed.savings_flexible_user_left_quota(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
