# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_load_record' do
  let(:path) { '/sapi/v1/margin/loan' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation asset' do
    let(:params) { { asset: '', recvWindow: 1_000 } }
    it 'should raise validation error without asset' do
      expect { spot_client_signed.margin_load_record(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        asset: 'BNB',
        txId: 'tx_id'
      }
    end
    it 'should query load record' do
      spot_client_signed.margin_load_record(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
