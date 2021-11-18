# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#enable_isolated_margin_account' do
  let(:path) { '/sapi/v1/margin/isolated/account' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation symbol' do
    let(:params) { { "symbol": '' } }
    it 'should raise validation error without symbol' do
      expect { spot_client_signed.enable_isolated_margin_account(**params) }.to raise_error(Binance::RequiredParameterError)
    end
  end

  context 'with symbol' do
    let(:params) { { "symbol": 'BNBUSDT' } }
    it 'should enable isolated margin account' do
      spot_client_signed.enable_isolated_margin_account(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
