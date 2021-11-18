# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_deposit_address' do
  let(:path) { '/sapi/v1/capital/deposit/subAddress' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "email": 'alice@test.com',
      "coin": 'BNB'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation email' do
    it 'should raise validation error without email' do
      expect { spot_client_signed.sub_account_deposit_address(email: '', coin: 'BNB') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation coin' do
    it 'should raise validation error without coin' do
      expect { spot_client_signed.sub_account_deposit_address(email: 'alice@test.com', coin: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return deposit address' do
    spot_client_signed.sub_account_deposit_address(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
