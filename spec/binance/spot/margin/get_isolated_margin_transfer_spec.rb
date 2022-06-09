# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#get_isolated_margin_transfer' do
  let(:path) { '/sapi/v1/margin/isolated/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:get, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { symbol: '' } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.get_isolated_margin_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with symbol' do
    let(:params) { { symbol: 'BNBUSDT' } }
    it 'should return isolated margin transfer history' do
      spot_client_signed.get_isolated_margin_transfer(**params)
      expect(send_a_request_with_signature(:get, path, params)).to have_been_made
    end
  end
end
