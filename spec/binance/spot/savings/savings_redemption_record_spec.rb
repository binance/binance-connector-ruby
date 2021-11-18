# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Savings, '#savings_redemption_record' do
  let(:path) { '/sapi/v1/lending/union/redemptionRecord' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      "lendingType": 'DAILY',
      "asset": 'BNB',
      "startTime": '1591673275033',
      "endTime": '1591673275033',
      "current": 1,
      "size": 100
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation' do
    it 'should raise validation error without lendingType' do
      expect { spot_client_signed.savings_redemption_record(lendingType: '') }.to raise_error(Binance::RequiredParameterError)
    end
  end

  it 'should return purchase record' do
    spot_client_signed.savings_redemption_record(**params)
    expect(send_a_request_with_signature(:get, path, params)).to have_been_made
  end
end
