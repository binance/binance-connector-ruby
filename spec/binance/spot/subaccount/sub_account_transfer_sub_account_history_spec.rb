# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_transfer_sub_account_history' do
  let(:path) { '/sapi/v1/sub-account/transfer/subUserHistory' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      asset: 'BNB',
      type: 1,
      startTime: 1_559_941_980_000,
      endTime: 1_559_941_980_000,
      limit: 100,
      recvWindow: 1_000
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  it 'should return sub account transfer history' do
    spot_client_signed.sub_account_transfer_sub_account_history(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
