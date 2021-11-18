# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_purchase_flexible_product' do
  let(:path) { '/sapi/v1/lending/daily/purchase' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "productId": 'product_id',
      "amount": 10
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without productId' do
      expect { spot_client_signed.savings_purchase_flexible_product(productId: '', amount: 1) }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without amount' do
      expect { spot_client_signed.savings_purchase_flexible_product(productId: '12344', amount: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should purchase flexible product' do
    spot_client_signed.savings_purchase_flexible_product(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
