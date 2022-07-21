# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#get_margin_dust_log' do
  let(:path) { '/sapi/v1/margin/dribblet' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:params) do
    {
      startTime: 1_631_688_673_000,
      endTime: 1_631_688_673_001
    }
  end

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with symbol' do
    it 'should return margin dust convert history' do
      spot_client_signed.get_margin_dust_log(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
