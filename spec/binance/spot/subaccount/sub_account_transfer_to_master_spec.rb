# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_transfer_to_master' do
  let(:path) { '/sapi/v1/sub-account/transfer/subToMaster' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "asset": 'BNB',
      "amount": 1
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation asset' do
    let(:params) do
      {
        "asset": '',
        "amount": 1
      }
    end
    it 'should raise validation error without asset' do
      expect { spot_client_signed.sub_account_transfer_to_master(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'validation amount' do
    let(:params) do
      {
        "asset": 'BNB',
        "amount": ''
      }
    end
    it 'should raise validation error without amount' do
      expect { spot_client_signed.sub_account_transfer_to_master(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should transfer funds to master account' do
    spot_client_signed.sub_account_transfer_to_master(**params)
    expect(send_a_request_with_signature(:post, path, params)).to have_been_made
  end
end
