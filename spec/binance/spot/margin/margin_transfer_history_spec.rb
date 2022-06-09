# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_transfer_history' do
  let(:path) { '/sapi/v1/margin/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }
  let(:asset) { 'BNB' }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'with parameters' do
    let(:params) do
      { asset: asset, type: 'ROLL_IN' }
    end
    it 'should query transfer history' do
      spot_client_signed.margin_transfer_history(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
