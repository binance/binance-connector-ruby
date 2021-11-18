# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Subaccount, '#sub_account_deposit_history' do
  let(:path) { '/sapi/v1/capital/deposit/subHisrec' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "email": 'alice@test.com',
      "coin": 'BNB',
      "status": 1,
      "startTime": 1_559_941_980_000,
      "endTime": 1_559_941_980_000,
      "limit": 1,
      "offset": 0
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation email' do
    it 'should raise validation error without email' do
      expect { spot_client_signed.sub_account_deposit_history(email: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return deposit history' do
    spot_client_signed.sub_account_deposit_history(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
