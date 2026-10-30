# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_interest_history' do
  let(:path) { '/sapi/v1/margin/interestHistory' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    let(:params) do
      {
        asset: 'BNB',
        startTime: '1581783387615',
        endTime: '1581783387616',
        current: 2,
        size: 100
      }
    end
    it 'should query load record' do
      spot_client_signed.margin_interest_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
