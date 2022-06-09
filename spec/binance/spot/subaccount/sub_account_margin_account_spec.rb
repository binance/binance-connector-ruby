# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_margin_account' do
  let(:path) { '/sapi/v1/sub-account/margin/account' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      email: 'alice@test.com'
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation email' do
    it 'should raise validation error without email' do
      expect { spot_client_signed.sub_account_margin_account(email: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return margin asset' do
    spot_client_signed.sub_account_margin_account(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
