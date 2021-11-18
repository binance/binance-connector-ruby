# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Blvt, '#get_subscribe_record' do
  let(:tokenName) { 'BTCDOWN' }
  let(:path) { '/sapi/v1/blvt/subscribe/record' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "tokenName": 'BTCDOWN',
      "id": 12_345,
      "startTime": 1_631_688_673_000,
      "endTime": 1_631_688_673_001,
      "limit": 100
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    it 'should get subscribe records' do
      spot_client_signed.get_subscribe_record(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
