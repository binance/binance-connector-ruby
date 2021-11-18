# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_asset_details' do
  let(:path) { '/sapi/v1/managed-subaccount/asset' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { { email: 'alice@test.com' } }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validate email' do
    it 'should raise validation error without email' do
      expect { spot_client_signed.sub_account_asset_details(email: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return sub account assets details' do
    spot_client_signed.sub_account_asset_details(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
