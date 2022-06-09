# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_force_liquidation_record' do
  let(:path) { '/sapi/v1/margin/forceLiquidationRec' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    let(:params) do
      {
        startTime: '1581783387615',
        endTime: '1581783387616',
        current: 2,
        size: 100
      }
    end
    it 'should query force liquidation record' do
      spot_client_signed.margin_force_liquidation_record(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
