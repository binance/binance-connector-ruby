# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_transfer_to_sub' do
  let(:path) { '/sapi/v1/sub-account/transfer/subToSub' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      toEmail: 'alice@test.com',
      asset: 'BNB',
      amount: 1
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation toEmail' do
    let(:params) do
      {
        toEmail: '',
        asset: 'BNB',
        amount: 1
      }
    end
    it 'should raise validation error without toEmail' do
      expect { spot_client_signed.sub_account_transfer_to_sub(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation asset' do
    let(:params) do
      {
        toEmail: 'alice@test.com',
        asset: '',
        amount: 1
      }
    end
    it 'should raise validation error without asset' do
      expect { spot_client_signed.sub_account_transfer_to_sub(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation amount' do
    let(:params) do
      {
        toEmail: 'alice@test.com',
        asset: 'BNB',
        amount: ''
      }
    end
    it 'should raise validation error without amount' do
      expect { spot_client_signed.sub_account_transfer_to_sub(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should transfer funds to sub account' do
    spot_client_signed.sub_account_transfer_to_sub(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
