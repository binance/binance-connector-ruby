# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Binance::Spot::Margin, '#isolated_margin_transfer' do
  let(:path) { '/sapi/v1/margin/isolated/transfer' }
  let(:body) { fixture('response.json') }
  let(:status) { 200 }

  before do
    mocking_signature_and_ts(**params)
    stub_binance_sign_request(:post, path, status, body, params)
  end

  context 'validation' do
    where(:params) do
      [
        { "asset": '', "symbol": 'BNBUSDT', transFrom: 'SPOT', transTo: 'ISOLATED_MARGIN', amount: 10 },
        { "asset": 'USDT', "symbol": '', transFrom: 'SPOT', transTo: 'ISOLATED_MARGIN', amount: 10 },
        { "asset": 'USDT', "symbol": 'BNBUSDT', transFrom: '', transTo: 'ISOLATED_MARGIN', amount: 10 },
        { "asset": 'USDT', "symbol": 'BNBUSDT', transFrom: 'SPOT', transTo: '', amount: 10 },
        { "asset": 'USDT', "symbol": 'BNBUSDT', transFrom: 'SPOT', transTo: 'ISOLATED_MARGIN', amount: '' }
      ]
    end
    with_them do
      it 'should raise validation error without mandatory params' do
        expect { spot_client_signed.isolated_margin_transfer(**params) }.to raise_error(Binance::RequiredParameterError)
      end
    end
  end

  context 'with complete params' do
    let(:params) { { "asset": 'USDT', "symbol": 'BNBUSDT', transFrom: 'SPOT', transTo: 'ISOLATED_MARGIN', amount: 10 } }
    it 'should transfer to isolated margin account' do
      spot_client_signed.isolated_margin_transfer(**params)
      expect(send_a_request_with_signature(:post, path, params)).to have_been_made
    end
  end
end
