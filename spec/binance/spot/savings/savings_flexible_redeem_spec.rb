# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_flexible_redeem' do
  let(:path) { '/sapi/v1/lending/daily/redeem' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      productId: 'product_id',
      amount: 1,
      type: 'FAST'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without productId' do
      expect { spot_client_signed.savings_flexible_redeem(productId: '', amount: 1, type: 'FAST') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without amount' do
      expect { spot_client_signed.savings_flexible_redeem(productId: '123456', amount: '', type: 'FAST') }.to raise_error(Binance::RequiredParameterError)
    end

    it 'should raise validation error without type' do
      expect { spot_client_signed.savings_flexible_redeem(productId: '123456', amount: 1, type: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should redeem product' do
    spot_client_signed.savings_flexible_redeem(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
