# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#withdraw' do
  let(:path) { '/sapi/v1/capital/withdraw/apply' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    let(:params) do
      {
        "coin": '',
        "address": 'bnb_address',
        "amount": 1,
        "limit": 30
      }
    end
    it 'should raise validation error without coin' do
      expect { spot_client_signed.withdraw(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        "coin": 'BNB',
        "address": 'bnb_address',
        "amount": 1,
        "withdrawOrderId": 'withdraw_order_id',
        "network": 'BNB',
        "addressTag": 'myaddress',
        "name": 'address_name'
      }
    end
    it 'should return account snapshot' do
      spot_client_signed.withdraw(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
