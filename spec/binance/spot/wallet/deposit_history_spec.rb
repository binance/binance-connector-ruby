# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Wallet, '#deposit_history' do
  let(:path) { '/sapi/v1/capital/deposit/hisrec' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) { {} }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    let(:params) do
      {
        "coin": 'BNB',
        "status": 1,
        "startTime": '1591833599000',
        "endTime": '1591833599000',
        "offest": 0,
        "limit": 30,
        "recvWindow": 1_000
      }
    end
    it 'should return deposit history' do
      spot_client_signed.deposit_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
