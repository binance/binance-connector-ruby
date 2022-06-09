# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#margin_max_borrowable' do
  let(:path) { '/sapi/v1/margin/maxBorrowable' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation asset' do
    let(:params) { { asset: '', recvWindow: 1_000 } }
    it 'should raise validation error without asset' do
      expect { spot_client_signed.margin_max_borrowable(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with parameters' do
    let(:params) do
      {
        asset: 'BNBUSDT',
        recvWindow: 1_000
      }
    end
    it 'should query max borrowable' do
      spot_client_signed.margin_max_borrowable(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
