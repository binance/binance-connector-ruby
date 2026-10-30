# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_status' do
  let(:path) { '/sapi/v1/sub-account/status' }
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

  it 'should return status' do
    spot_client_signed.sub_account_status(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
