# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_interest_rate_history' do
  let(:path) { '/sapi/v1/margin/interestRateHistory' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation asset' do
    let(:params) { { "asset": '', "recvWindow": 5000 } }
    it 'should raise validation error without asset' do
      expect { spot_client_signed.get_margin_interest_rate_history(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        "asset": 'BNB',
        "recvWindow": 5000
      }
    end
    it 'should return margin interest rate history' do
      spot_client_signed.get_margin_interest_rate_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
